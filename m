Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318492F20E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbhAKUcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbhAKUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:32:40 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A01C061786;
        Mon, 11 Jan 2021 12:32:00 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E36C69B2;
        Mon, 11 Jan 2021 20:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E36C69B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610397120; bh=26pO2/zq+dBjgEu9pl4QKeQ5FvwMWC8q9w3/eaxa6O8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DPPdGuerm6JpqKf7UkmXiL9/k9jPonkJgb9Y4o6lyZrtu/gv69D+GdD+A4EJgWzt/
         i9EgmQJ6A5M6k+JvKLK0xg+ZZAytckhCl0lqEIYlan31xb3FAgoncuefyeWLMXjjFM
         kKQD3xLO/pHwUkmdqTTozPD4h9u7R8FB/IEdTCNqdzuu/4A6z8az/XD6lkn2t4bRVq
         5Prc8qXJgwmVakLztmb+HBLqgDE5fszdaJ4Pt/VQXq1x/TCNiVq/ORSVLRrZ2g2/ke
         JEbn7wkt9QKolgNc62wto2LhK4Trqo47jlGC5iWFZSjjdQcZbtxCnRHo6hGlA8Ue4U
         9oVRGAJBOTH5w==
Date:   Mon, 11 Jan 2021 13:31:58 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Michael Witten <mfwitten@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-model: bus.rst: Clean up the formatting,
 expound, modernize
Message-ID: <20210111133158.34923b4c@lwn.net>
In-Reply-To: <3dc7d8abd06941fca5071b0ede9b6088@gmail.com>
References: <3dc7d8abd06941fca5071b0ede9b6088@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 07:52:00 -0000
Michael Witten <mfwitten@gmail.com> wrote:

> * The reStructuredText had some indentation issues.
> 
> * The HTML output was not properly formatted in places.
> 
> * Some of the details were lacking or needed clarification (especially
>   with regard to how a `struct bus_type` object should be defined).
> 
> * The sysfs example hierarchy appeared outdated; I've updated it with
>   output based on what my own system currently displays.
> 
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  Documentation/driver-api/driver-model/bus.rst | 110 +++++++++++++--------
>  1 file changed, 67 insertions(+), 43 deletions(-)

Thanks for working to improve the docs.  I have a couple of requests,
though... 

> diff --git a/Documentation/driver-api/driver-model/bus.rst b/Documentation/driver-api/driver-model/bus.rst
> index 016b15a6e8ea..68a95389b1eb 100644
> --- a/Documentation/driver-api/driver-model/bus.rst
> +++ b/Documentation/driver-api/driver-model/bus.rst
> @@ -4,34 +4,58 @@ Bus Types
>  
>  Definition
>  ~~~~~~~~~~
> -See the kerneldoc for the struct bus_type.
> -
> -int bus_register(struct bus_type * bus);
> +* ``struct bus_type``;
> +* ``int bus_register(struct bus_type *bus);``

This should just be made into a literal block like the others.

>  Declaration
>  ~~~~~~~~~~~
>  
> -Each bus type in the kernel (PCI, USB, etc) should declare one static
> -object of this type. They must initialize the name field, and may
> -optionally initialize the match callback::
> +For each bus type (PCI, USB, etc), there should be code that defines
> +one object of type ``struct bus_type``:

It is better not to mark types as ``literal`` this way; the build system is
getting better at recognizing such things on its own and generating the
appropriate links.

[...]

>  Registration
>  ~~~~~~~~~~~~
>  
> -When a bus driver is initialized, it calls bus_register. This
> -initializes the rest of the fields in the bus object and inserts it
> -into a global list of bus types. Once the bus object is registered,
> +During initialization of a bus driver, ``bus_register()`` is called; this

*definitely* don't mark functions as literal in this way; simply say
 bus_register() and the Right Things will happen.

Thanks,

jon
