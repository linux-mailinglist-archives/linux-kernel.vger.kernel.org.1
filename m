Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D022E971B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbhADOVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:21:37 -0500
Received: from n7.nabble.com ([162.253.133.57]:51460 "EHLO n7.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADOVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:21:36 -0500
X-Greylist: delayed 635 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2021 09:21:36 EST
Received: from n7.nabble.com (localhost [127.0.0.1])
        by n7.nabble.com (Postfix) with ESMTP id BEBB61CC945F6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:11:41 -0700 (MST)
Date:   Mon, 4 Jan 2021 07:11:41 -0700 (MST)
From:   Avi Nehori <anehori@gmail.com>
To:     linux-kernel@vger.kernel.org
Message-ID: <1609769501778-0.post@n7.nabble.com>
In-Reply-To: <alpine.DEB.2.02.1405130156550.10293@dtop>
References: <alpine.DEB.2.10.1401171720560.15759@dinf> <1390027758.31367.505.camel@edumazet-glaptop2.roam.corp.google.com> <1390028976.31367.512.camel@edumazet-glaptop2.roam.corp.google.com> <alpine.DEB.2.10.1401172313530.18419@dinf> <CAADnVQKQFQh2JewwmXWBkyB86rOJs1mXHrgECikaMxGqFW3axA@mail.gmail.com> <alpine.DEB.2.02.1401211735170.20572@dtop> <alpine.DEB.2.02.1401212008010.20572@dtop> <CAADnVQ+MNHFKmCSS7m42s7gz68sCwNUY4U571R5XVH0sU0=ffQ@mail.gmail.com> <CAADnVQ+nmc3_8yt=WxWpQ1vKe8kh+mCFTi6-iSn11drPpqFiDg@mail.gmail.com> <alpine.DEB.2.02.1405130156550.10293@dtop>
Subject: Re: ipv4_dst_destroy panic regression after 3.10.15
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
i am having similar crash on 3.10 , can you please share your conclusion ?
is there a patch for the issue ?

Thanks.




--
Sent from: http://linux-kernel.2935.n7.nabble.com/
