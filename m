Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955142F417B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbhAMCEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:04:09 -0500
Received: from mail-m971.mail.163.com ([123.126.97.1]:35488 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAMCEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=eMNxF
        iVUJuCmXE2LvlbxSalazyqLhoJJzPCczdrD7bo=; b=OeWZhnaZmWDzWmh3WGjfx
        /fczRww9yxE5bvC7Vdd8Fzcg2xZo+2xZsTZ73f4evlv9MXB3Jk1VcmOzocHzB2Xx
        KKXfi9nY+vwwRwSvnVDRRL0TkLdusuBHACtJaEV8mpBYK+BZ9BaaN2stLTPOnoFx
        njI/XTtKY1YZ/4Be8YRorI=
Received: from [128.224.155.93] (unknown [60.247.85.82])
        by smtp1 (Coremail) with SMTP id GdxpCgDHxLmrVP5ffVoICQ--.93S2;
        Wed, 13 Jan 2021 10:02:20 +0800 (CST)
Subject: Re: [PATCH 1/2] init/main.c: fix strings split across lines
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20201230060424.29097-1-liupeibao@163.com>
 <20201230060424.29097-2-liupeibao@163.com>
 <20210111190235.3e81770f@gandalf.local.home>
 <7a7886b2-c3bd-5adc-5d94-67343e554759@163.com>
 <20210112161124.2789c67e@gandalf.local.home>
From:   Liu Peibao <liupeibao@163.com>
Message-ID: <6843b1c0-cbea-98c5-4c37-6a5aae25893e@163.com>
Date:   Wed, 13 Jan 2021 10:02:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112161124.2789c67e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GdxpCgDHxLmrVP5ffVoICQ--.93S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryfGr17Zr4fJr18CryrXrb_yoWDXFX_Ka
        yvyr92yw1DZF47JanIkF15ZFZxArs7GF1UAry5JanxZ34rZFZ7WanrKr97Z3W5JayktFn8
        Crs8Zas5Aw1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe0_M3UUUUU==
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/1tbiyQwZbFQHMpG9-AAAsB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 5:11 AM, Steven Rostedt wrote:
> On Tue, 12 Jan 2021 22:26:21 +0800
> Liu Peibao <liupeibao@163.com> wrote:
> 
>> Thanks for your replay! I get it.
>> But I still feel a little confused that we use different standard to
>> measure the existing code and the new code. I also checked some commits,
>> there are similar patches too.
> 
> For the reason of different standards for existing code to new code. Think
> of it as a "grandfather clause". Where rules change for new instantiations,
> but if you already have something, you can still use the old rules. Hmm,
> it's kind of like how RCU works!
> 
> As for some commits getting it. They sometimes get pulled in by various
> maintainers, and also may happen if you are changing the code around
> something. With the "one commit does one thing", you can have a "clean up
> code" patch followed by a "change the code" patch. matters what the context
> is.
> 
> -- Steve
> 
Whoa, the RCU example is really amazing!
Thanks for your detailed explanation.

BR,
Peibao

