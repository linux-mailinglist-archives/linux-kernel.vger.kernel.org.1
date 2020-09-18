Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D043D2700C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:18:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61976C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=BlEgLx9zDdAig7bGm8vvBKo70dBV9kO3kLRVnfLZehc=; b=v6DEwh5bOhP/rboe78JE+Nxdoq
        N5nCduoRmzHnTMQjg54XZ+oXD8C3cSsQesZ2k4+ppBCltgXOaLAVCvwW09vO0SF9Yg8U0vK8ABkor
        Wy0B44UslUwDv4N78Q9KoIFiwrVJ+YwUaFJTrOlIMe+TyAfuw73iIvsb0Izb/NB9Ohj02v7VLdAJq
        rxY3OCxO0fg5fwrvE+EukVPBOcYtH+wAGxA+ejm64fvBY6XcxYy+gT4GG4Nc5u+bdUCXsxpdPNzCB
        dTP+vGuW10buD8YuN7iAi3j1QQtOpFwrD3p6LWz3hljPgJEoXpFeSczqA/1J4VTK1PasGerK/Zhtm
        Is5OG+6A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJI9f-0001hW-At; Fri, 18 Sep 2020 15:18:31 +0000
Subject: Re: Am I the only one seeing stale stable version on lkml.org!!
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
References: <20200918120628.GA1332871@ArchLinux>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7f111351-28b5-b08a-53d9-738eba967142@infradead.org>
Date:   Fri, 18 Sep 2020 08:18:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918120628.GA1332871@ArchLinux>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 5:06 AM, Bhaskar Chowdhury wrote:
> Hi,
> 
> I have seen it two different machines and two different browsers ...still seeing the stale "stable" version on the page. Tried the "clear cache" method too.
> 
> Can someone please look into it and update. I have attached a screenshot with
> this mail for your reference.

Hey Bhaskar,

That's an unofficial email archive website. Nobody at kernel.org has anything
to do with it.

You could try to contact Jasper Spaans about it if you want to pursue it.

Better to just user kernel.org for stable release into and
lore.kernel.org for email archives.


-- 
~Randy

