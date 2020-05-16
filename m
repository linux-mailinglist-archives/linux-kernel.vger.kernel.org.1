Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3A01D5F60
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 09:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgEPHTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 03:19:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4797 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbgEPHTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 03:19:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B580D942583F32C4960F;
        Sat, 16 May 2020 15:19:33 +0800 (CST)
Received: from [10.166.215.145] (10.166.215.145) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 15:19:29 +0800
Subject: Re: [PATCH] kdb: Make the internal env 'KDBFLAGS' undefinable
To:     Doug Anderson <dianders@chromium.org>
CC:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200511021637.37029-1-liwei391@huawei.com>
 <CAD=FV=VNTkRW9LbNjY_0Ljj57m19gFUEHAuYKd-i6jpu_QpMgg@mail.gmail.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <1672625a-5f2b-33db-c516-42abb070a26e@huawei.com>
Date:   Sat, 16 May 2020 15:19:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VNTkRW9LbNjY_0Ljj57m19gFUEHAuYKd-i6jpu_QpMgg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On 2020/5/14 7:41, Doug Anderson wrote:

>> -       }
>> +       } else if (strcmp(argv[1], "KDBFLAGS") == 0)
>> +               return KDB_NOPERM;
> 
> One slight nit is that my personal preference is that if one half of
> an "if/else" needs braces then both halves should have braces.  I
Thanks for spotting it. Refer to Documentation/process/coding-style.rst, i
will fix it in the v2.

> don't know what Daniel and Jason's policies are, though.  In any case,
> not that I've ever used the KDBDEBUG functionality, but your change
> seems sane.  Without it if I set "KDBDEBUG" and "KDBFLAGS" and then
> type "env" I see the flags listed twice, but one is real and one is
> fake.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> -Doug
> 

Thanks,
Wei
