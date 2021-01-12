Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92CB2F2A33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405616AbhALImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:42:50 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:58088 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731341AbhALImt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:42:49 -0500
Received: from [192.168.1.91] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 92A97780380;
        Tue, 12 Jan 2021 09:41:55 +0100 (CET)
Subject: Re: Old platforms: bring out your dead
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <c969392572604b98bcb3be44048c3165@hisilicon.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <e5621b81-166e-a03e-7127-4cb864f6cf35@free.fr>
Date:   Tue, 12 Jan 2021 09:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c969392572604b98bcb3be44048c3165@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2021 21:25, Song Bao Hua (Barry Song) wrote:

> I got confirmation from Qualcomm guys that there is no plan
> to maintain prima2 in mainline any more.
> Please feel free to remove the code. If you need my help,
> Please let me know.

Hello Barry,

I didn't know that qualcomm worked on mainline kernels, except through
the Code Aurora and Linaro arrangement.

Was the mainline work done by CSR plc /before/ it was swallowed by qcom?
https://en.wikipedia.org/wiki/CSR_(company)

Regards.
