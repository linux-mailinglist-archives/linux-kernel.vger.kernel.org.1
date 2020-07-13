Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBFD21D8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgGMOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbgGMOeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:34:11 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78414C061755;
        Mon, 13 Jul 2020 07:34:11 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C7D2260C;
        Mon, 13 Jul 2020 14:34:09 +0000 (UTC)
Date:   Mon, 13 Jul 2020 08:34:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: Replace HTTP links with HTTPS ones
Message-ID: <20200713083408.38154746@lwn.net>
In-Reply-To: <20200713141036.34841-1-grandmaster@al2klimov.de>
References: <20200713141036.34841-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 16:10:36 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 1fa2fe2ef053..f21f121a8f42 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -223,7 +223,7 @@ config SMP
>  	  will run faster if you say N here.
>  
>  	  See also the SMP-HOWTO available at
> -	  <http://www.tldp.org/docs.html#howto>.
> +	  <https://www.tldp.org/docs.html#howto>.

No such HOWTO exists; far better to just delete this sentence entirely.

jon
