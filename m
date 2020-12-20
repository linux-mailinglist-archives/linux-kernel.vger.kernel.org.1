Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC912DF297
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 02:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgLTBZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 20:25:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:35387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgLTBZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 20:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608427430;
        bh=Ce9S6zrCQf0NChxGGpooimbJN6N08uPt4ubX6/bcgIQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=DUWpuql0D50N/j4H+x1vvXtsvi3pOU2QL8/5lJEXwnG/ApY4ev8rY//Va/D5ErEU8
         RPPR+67WxcU9l6/Ohpp42rGCVCh57HKU9AabFgj7t+uhDM8lFM9fSsLSuy83WA8T67
         dCPauCoCyZPDrVbBY+gDXsWwKHttOGfgvJD59MGQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1jvp393CJV-00viGb; Sun, 20
 Dec 2020 02:23:50 +0100
Message-ID: <c9c97ae293f5d7321ff30ac6ead49751560dd354.camel@gmx.de>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Date:   Sun, 20 Dec 2020 02:23:49 +0100
In-Reply-To: <20201220002228.38697-1-vitaly.wool@konsulko.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
         <20201220002228.38697-1-vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ax83T0xYQBFJVPHbUHlYTrPgRB/Ee2Y7lhC9LgoB66EzLjnZ4S9
 WJ8dtz4Va8Rkvg8hhJPRMXpW2n9w2u/bsZFtSBauU1vxrCdciB8rFzMDmShI/ZMSviLut+P
 kqkR2FzgQhpBzSdo+5jqYZsWkdT7Z/q9e94G/EEKxGD5gZ7UGyYgi+52iK56e3HLCtr2/37
 J2GPFeL526alLAJKeqi6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:suzbf/ZH2+g=:89lWwvuF2Bio+yeNtbWWMp
 xu+GM4I4dv86q3igfO1Y+JPnvqU3xNSdFGZAplGGzEjBjBBS1ltBOcj//TooCkKvhwYfQ2nCa
 zd+P6/K7B6DksOZC5beeuWVVSy5NSKZcXr3B76HMMZmhEN0rUgggeSkoj4A2Tcrz5JjKrAy9i
 6QucYBA/JUKcHRYkncSz8MalBbBaqISM+WqbNFBnjsSvXMtKQMdq3Ujg7nl/xs2HAYR5e8/kF
 z/9AkBJkE8v7y0TM+OojO7rDLGVRC+jBe9wW+KDOo+QI+fyeRgi9thKQ4e6wha8+3y5nPkQm0
 p0Yvou40VUuwSZlAh/u4FzcCbFw/BlsbD/CCbuE32Alds9zRmmvsDSrGdk38ZR/ag/9230v1z
 cVVWeyI9ooso0YUVF/OhbansPlJlnwD7n9jQ6AcVglBoW3f/4OlohjhINxZb85nUYaNhzQC5b
 2ZVos3Mrxk5Dm5Q6+fAWvy73xmnHkGowtM5ST2m6MRH7+Q6YJtp08spFHF8nz4hoj8p0B3sN9
 xFaN8nQCQaX7/mtGBZbS+LUYvh2lymHDKrCx3f/SHJO1eiXhgfpXQRQT4tEL6f1z09P2CL6Ny
 WumiRIwinIExnzh9D5KdeJyKU9xx0L2EUnM2nU8wtSvMNR05IFxg2CFY1coZjHhAWeQb7BczG
 PjuwMVNLQHLcnLIEiU2k9dKk+g1Bg25RMY7CLRvaIu/cy6wf+4h4HI+1Q7BWJMkmxSEp0gNNp
 RweW9OTXEWALp479tFyt7j71JjU1ImHek0bn0vyHam6Ks8qKQir7FMFYD8TuHADoiPffqh8OK
 khy70wH39+3MClAM4YQ+mSIUzYDbW4oGm+QnmdCRAsYPSvPIr7x96FbRBdtfknBrNMdCmHisY
 4cVwld1y8mLTfBVMN/WA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-12-20 at 02:22 +0200, Vitaly Wool wrote:
> zsmalloc takes bit spinlock in its _map() callback and releases it
> only in unmap() which is unsafe and leads to zswap complaining
> about scheduling in atomic context.
>
> To fix that and to improve RT properties of zsmalloc, remove that
> bit spinlock completely and use a bit flag instead.

It also does get_cpu_var() in map(), put_cpu_var() in unmap().

	-Mike

