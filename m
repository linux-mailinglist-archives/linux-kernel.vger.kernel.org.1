Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBE270A07
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgISC0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:26:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgISC0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:26:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3A9FAAE83476303B3A4;
        Sat, 19 Sep 2020 10:26:45 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 10:26:35 +0800
Subject: Re: [PATCH] vt: fix some doc warnings in vt.c
To:     Jiri Slaby <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>,
        <nico@fluxnic.net>, <linux-kernel@vger.kernel.org>
References: <1600415225-17736-1-git-send-email-tanxiaofei@huawei.com>
 <f03ee775-8a49-f1d0-b28b-73489f5b8be2@kernel.org>
CC:     <linuxarm@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F656C5B.9050106@huawei.com>
Date:   Sat, 19 Sep 2020 10:26:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <f03ee775-8a49-f1d0-b28b-73489f5b8be2@kernel.org>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2020/9/18 15:52, Jiri Slaby wrote:
> On 18. 09. 20, 9:47, Xiaofei Tan wrote:
>> Fix following warnings caused by mismatch bewteen function parameters
>> and comments.
>> drivers/tty/vt/vt.c:3994: warning: Function parameter or member 'vc' not described in 'con_debug_enter'
>> drivers/tty/vt/vt.c:3994: warning: Excess function parameter 'sw' description in 'con_debug_enter'
>> drivers/tty/vt/vt.c:4051: warning: Excess function parameter 'sw' description in 'con_debug_leave'
> 
> It looks like I fixed those in
> https://lore.kernel.org/r/20200818085655.12071-6-jslaby@suse.cz
> too. Could you rebase on the top of tty-next?
> 

Oh, yes, I used a different branch.
Thanks for your remind.


> thanks,
> 

-- 
 thanks
tanxiaofei

