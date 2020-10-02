Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23BC280F29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbgJBIns convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Oct 2020 04:43:48 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:56358 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgJBInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:43:47 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22599471-1500050 
        for multiple; Fri, 02 Oct 2020 09:43:27 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201002082740.GI393@shao2-debian>
References: <20201002082740.GI393@shao2-debian>
Subject: Re: [drm/i915/gt] 98479ada42: phoronix-test-suite.supertuxkart.1024x768.Windowed.Basic.1.OldMine.frames_per_second -36.0% regression
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andi Shyti <andi.shyti@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, guobing.chen@intel.com,
        ming.a.chen@intel.com, frank.du@intel.com, Shuhua.Fan@intel.com,
        wangyang.guo@intel.com, Wenhuan.Huang@intel.com,
        jessica.ji@intel.com, shan.kang@intel.com, guangli.li@intel.com,
        tiejun.li@intel.com, yu.ma@intel.com, dapeng1.mi@intel.com,
        jiebin.sun@intel.com, gengxin.xie@intel.com, fan.zhao@intel.com
To:     kernel test robot <rong.a.chen@intel.com>
Date:   Fri, 02 Oct 2020 09:43:25 +0100
Message-ID: <160162820546.4780.2561710802505007406@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kernel test robot (2020-10-02 09:27:40)
> Greeting,
> 
> FYI, we noticed a -36.0% regression of phoronix-test-suite.supertuxkart.1024x768.Windowed.Basic.1.OldMine.frames_per_second due to commit:

Where's the power consumption graph? You have a benchmark that although
is running faster than the display is failing to keep the GPU busy. That
alone says there is a latency issue along the GL paths. Is papering over
an issue in command submission worth the power cost?
-Chris
