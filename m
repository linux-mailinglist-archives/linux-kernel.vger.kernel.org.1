Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4F1EF590
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgFEKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 06:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgFEKoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:44:25 -0400
Received: from linux-8ccs (p57a23121.dip0.t-ipconnect.de [87.162.49.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E1692075B;
        Fri,  5 Jun 2020 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591353865;
        bh=zq0dLpWeux6wGCdLIRjeW49wWf65BJVsXb+ImWJe0Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zLDyNKt2wA2sIILms0TpT1ELfdaj00VWXxueBEwXnmGars3JRPdiOUE4URHVbFNfU
         CLx8MHL9TGKfUrL6r/cWR1i9yMldygv9Ak9NQOv/ABauMNqFhbXmlPbnSdi2PzOKD6
         1XIkrFZzXImQsTchjpfdfkdmRI2Yk4XRlXqlxfJA=
Date:   Fri, 5 Jun 2020 12:44:21 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: unable to compile after "module: Make module_enable_ro() static
 again"
Message-ID: <20200605104421.GC24474@linux-8ccs>
References: <CADxRZqwxxvxo_JhtDVX7ke09tVDOW-d6dz4bw1OVhHETnrE+mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADxRZqwxxvxo_JhtDVX7ke09tVDOW-d6dz4bw1OVhHETnrE+mQ@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Anatoly Pugachev [05/06/20 13:21 +0300]:
>Hello!
>
>i'm unable to compile kernel on debian sid/unstable (tested on sparc64
>and ppc64) after commit e6eff4376e2897c2e14b70d87bf7284cdb093830

There are some module changes that still need to be merged that should
fix this issue. Please wait until after the merge window or at least
until after the following pull request gets merged into mainline:

    https://lore.kernel.org/r/20200605093354.GA23721@linux-8ccs.fritz.box

Thanks, and apologies for the inconvenience,

Jessica
