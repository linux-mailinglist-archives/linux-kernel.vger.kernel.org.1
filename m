Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0122D83B4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 02:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405926AbgLLBCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 20:02:52 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:40240 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgLLBCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 20:02:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id A9C6D20139B9;
        Sat, 12 Dec 2020 09:01:10 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fkzVN13TR3aC; Sat, 12 Dec 2020 09:01:10 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 85A3420139AC;
        Sat, 12 Dec 2020 09:01:10 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.105])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id C4B18C01FB5;
        Sat, 12 Dec 2020 09:01:08 +0800 (HKT)
Subject: Re: [PATCH 0/6] mmc: core: hs400(es) fix probe/init
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jack <jack.lo@gtsys.com.hk>
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <20f13970-4a9a-82c9-0765-7aa2cf95ce77@gtsys.com.hk>
Date:   Sat, 12 Dec 2020 09:01:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No Comments ?

Chris

On 8/12/2020 2:18 pm, Chris Ruehl wrote:
> Fix the probe if hs400-1_8v / hs400-1_2v is used in the
> dts and mmc-hs400-enhanced-strobe isn't set.
> That was the first attemped, but it turns out that some
> more cleanups and simplifications can be done.
> 
> * move mmc_select_hs400() in between hs200 & hs400es (preparation)
> * make mmc_select_hs400() independent and move it out
>    of the hs200. Run hs400 tuning inside mmc_select_hs400();
> * merge hs400 with hs400es function
> * remove mmc_select_hs400es function
> * remove mmc_hs200_tuning()
> * cleanup host->caps2 for hs400-1_8(2)v
> 
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
> Replace patch set [PATCH 0/3] mmc: core: hs400 fix probe
> 
