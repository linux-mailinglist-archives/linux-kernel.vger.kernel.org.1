Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B162037A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 15:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgFVNOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 09:14:38 -0400
Received: from ms.lwn.net ([45.79.88.28]:37496 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgFVNOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:14:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 518A2738;
        Mon, 22 Jun 2020 13:14:36 +0000 (UTC)
Date:   Mon, 22 Jun 2020 07:14:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pavel Machek <pavel@denx.de>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        changbin.du@intel.com, masahiroy@kernel.org, rostedt@goodmis.org,
        j.neuschaefer@gmx.net, andy.shevchenko@gmail.com,
        mchehab+samsung@kernel.org, logang@deltatee.com, abbotti@mev.co.uk,
        jacob.e.keller@intel.com, colin.king@canonical.com,
        gregkh@linuxfoundation.org, mgreer@animalcreek.com, tytso@mit.edu,
        jack@suse.cz, ebiggers@google.com, tglx@linutronix.de,
        akpm@linux-foundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, cohuck@redhat.com,
        jacek.anaszewski@gmail.com, alex@alexanderweb.de,
        dwlsalmeida@gmail.com, dsterba@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/admin-guide
Message-ID: <20200622071435.044eb001@lwn.net>
In-Reply-To: <20200621220432.GA916@amd>
References: <20200621132049.45624-1-grandmaster@al2klimov.de>
        <20200621220432.GA916@amd>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 00:04:32 +0200
Pavel Machek <pavel@denx.de> wrote:

> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.  
> 
> > +++ b/Documentation/admin-guide/README.rst
> > @@ -1,6 +1,6 @@
> >  .. _readme:
> >  
> > -Linux kernel release 5.x <http://kernel.org/>
> > +Linux kernel release 5.x <https://kernel.org/>
> >  =============================================
> >  
> 
> You need to add one "=" here, IIRC.

Or just remove the URL from the subheading entirely, it does not really
serve any purpose there.

jon
