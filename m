Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2047F27059F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIRTdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:33:04 -0400
Received: from lobo.ruivo.org ([173.14.175.98]:40950 "EHLO lobo.ruivo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgIRTdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:33:04 -0400
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 85F8853123; Fri, 18 Sep 2020 15:26:16 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tate.lan.ruivo
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.5 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 0BE6352EBB;
        Fri, 18 Sep 2020 15:25:57 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id CE8C11A52B6; Fri, 18 Sep 2020 15:25:57 -0400 (EDT)
Date:   Fri, 18 Sep 2020 15:25:57 -0400
From:   "aris@ruivo.org" <aris@ruivo.org>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/7] HWpoison: further fixes and cleanups
Message-ID: <20200918192557.GB18315@cathedrallabs.org>
References: <20200917081049.27428-1-osalvador@suse.de>
 <20200917113920.GA19898@hori.linux.bs1.fc.nec.co.jp>
 <20200917130948.GA1812@linux>
 <20200917133959.GA2504@linux>
 <20200917152717.GA26808@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917152717.GA26808@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:27:18PM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> The test passed in my environment, so this is fine.

With everything applied, it works for me as well.
(apologies for the delay, the machine I was using stopped working and took a
while to get another one)

-- 
Aristeu

