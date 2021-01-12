Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D642F3766
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbhALRkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbhALRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:40:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98CC061794;
        Tue, 12 Jan 2021 09:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2pPPhrxgRtHCGXKNAyS2DWDRTyhPu01Ss0FZFp58vxQ=; b=tjeh69wnZ3Uc3cUL7S8hqIqMcx
        GlRdTOBB6FToDN9zsdefzbTpHAAid3+NXcnsJxLRvLtGpBtuWixKRzI1JaSjXSw9vZQ84QUZs6ZoS
        8H2k180wrGFYmDSwkFR0sEIwi1llBv/TQIzk60muOos2a2SR0Fy4yhvFDXlvUqhdWo7PVTRHIo46b
        ZWmW4z11IqzTrkWSKXFaBk/n6gUTl0dbZZEepM4L96/ImDixm8cdksv/6WTv7QSc+J+30qvi0VTAf
        IOM2GKPTc34Syu+wZywvMLVgPj8lxVoPVHi20CjOvNquQBsQNHR6BmyJyk1nz42GdqPrCLm2ynu/4
        Ijxj8VdQ==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzNdp-00015h-Oj; Tue, 12 Jan 2021 17:39:38 +0000
Subject: Re: [PATCH v3 1/3] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To:     Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com,
        perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
References: <20210112171723.19484-1-Perry_Yuan@Dell.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cc83351b-a19a-9a3e-d511-4553cf4d7ef0@infradead.org>
Date:   Tue, 12 Jan 2021 09:39:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112171723.19484-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 9:17 AM, Perry Yuan wrote:
> +config DELL_PRIVACY
> +	tristate "Dell Hardware Privacy Support"
> +	depends on ACPI
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	depends on DELL_LAPTOP
> +	depends on LEDS_TRIGGER_AUDIO
> +	select DELL_WMI
> +	help
> +	This driver provides support for the "Dell Hardware Privacy" feature
> +	of Dell laptops.
> +	Support for a micmute and camera mute privacy will be provided as
> +	hardware button Ctrl+F4 and Ctrl+F9 hotkey

	End above with a period '.' please.

> +
> +	To compile this driver as a module, choose M here: the module will
> +	be called dell_privacy.

Please follow coding-style for Kconfig files:

from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


thanks.
-- 
~Randy

