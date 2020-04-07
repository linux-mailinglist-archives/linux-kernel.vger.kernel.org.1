Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB61A0AA1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgDGKBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 06:01:10 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38248 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgDGKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DFNz1XFQCqB0ki2rrudESMlC1higHzCyKjV7JRMfmtI=; b=TKPdbBqchi8ItHrKkREA5fEPY
        WrhftoGdqP393vXFaanrgK4MHLbY/aGdoVqSOMJgUxM3U+7ICHKQ5jPZYZ932Qk3p0VVbNQf352RU
        6/lSNjyxQOWAfPXPWQcTVvt8zKrBGYbAU2hkPeBlvJYYXx19xn7unSSx057jloNKHqZULVOAwCG72
        2n9hQYBdG2c2Urweyl37UhA8NFN0AQMeplm2AVy3qks47f+jllFHM21fdsphHbmf00YCjjgmhLWIG
        ZULMubT3MRUoCgqO3DbzJhkeSY9FXX2eEwKhWQ1TfuPdFkxHofAbiQ2Lweoq1znSf+4K/W3UCZbWT
        G/bsSl+Zg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:35144)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jLl2U-0007CO-1L; Tue, 07 Apr 2020 11:01:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jLl2S-0007DF-8f; Tue, 07 Apr 2020 11:01:00 +0100
Date:   Tue, 7 Apr 2020 11:01:00 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, wens@csie.org, ebiederm@xmission.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200407100100.GJ25745@shell.armlinux.org.uk>
References: <20200406082720.GA31279@Red>
 <20200406091600.GF25745@shell.armlinux.org.uk>
 <20200406092540.GB31279@Red>
 <20200406093729.GG25745@shell.armlinux.org.uk>
 <20200406201053.GA10931@Red>
 <20200407073117.GH25745@shell.armlinux.org.uk>
 <20200407080144.GA20773@Red>
 <20200407081257.GI25745@shell.armlinux.org.uk>
 <20200407093253.GA4630@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407093253.GA4630@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:32:53AM +0200, Corentin Labbe wrote:
> On Tue, Apr 07, 2020 at 09:12:57AM +0100, Russell King - ARM Linux admin wrote:
> > That was not reflected in the command lines given to kexec that you
> > quoted previously, so I'm now wondering if you're giving me the full
> > information.
> > 
> > In any case, based on the information you've supplied thus far, I have
> > no further suggetsions to make.
> > 
> 
> Sorry I have added --debug after my initial mail.
> But I am surprised that no debug output like "MEMORY RANGES" is done (like I got in my first try).
> I have started to patch kexec-tools to check it, and debug is enabled.
> Furthermore, I got in locate_hole:237 memory_ranges=0.
> So the memory region in struct kexec_info is not initialized (and so cannot be printed)

The memory region information is initialised by get_memory_ranges()
in kexec/arch/arm/kexec-arm.c, which reads /proc/iomem.

That is called from my_load(), which checks that info.memory_ranges
is non-zero.  If it's zero, it errors out with "Could not get memory
layout".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
