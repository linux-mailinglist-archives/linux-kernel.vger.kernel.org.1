Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777472A26BF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgKBJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:13:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7571 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgKBJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:13:53 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPnK81phMzLscn;
        Mon,  2 Nov 2020 17:13:48 +0800 (CST)
Received: from DESKTOP-2DH7KI2.china.huawei.com (10.67.101.108) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 17:13:40 +0800
From:   Chengsong Ke <kechengsong@huawei.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangfangpeng1@huawei.com>
Subject: Re: [PATCH v2] ubifs: Fix the printing type of c->big_lpt
Date:   Mon, 2 Nov 2020 17:13:40 +0800
Message-ID: <20201102091340.30712-1-kechengsong@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201031085420.1316-1-kechengsong@huawei.com>
References: <20201031085420.1316-1-kechengsong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 9:56 AM Chengsong Ke <kechengsong@huawei.com> wrote:
>
> Ubifs uses %d to print c->big_lpt, but c->big_lpt is a variable of 
> type unsigned int and should be printed with %u.
>
> Well, it is:
> unsigned int big_lpt:1;
> So, either 0 or 1.
> 
> Does changing it to %u silence some static checker or is there some 
> other problem I don't see right now? :-)
> 
> Thanks,
> //Richard

This is just a coding style issue, I found in the ubifs code. :-) 
Thanks, 
//Chengsong Ke
