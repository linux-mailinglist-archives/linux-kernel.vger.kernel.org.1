Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA4D2E19D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgLWIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:15:44 -0500
Received: from m12-16.163.com ([220.181.12.16]:51441 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgLWIPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=/egXJ
        Aw/EhIW4O77LFNuHJg+n25TKBrltHYWqi3Kpek=; b=h7X9h60GmH2oIl4AknWBy
        EzGjzYskkr+V3MyXekwc2XN8Jd7uDJKlBWzjpyWcCcKiR6e1cqrvo/UtBbMkWn22
        7ynr3leWiwFW2uDRh90eNVXRN2Sk2n9H16gtCOTUNyPAthVW07ONuIp9s8N/o6A8
        2A01+JPqPdr9qJGa4Bz4Pk=
Received: from localhost (unknown [101.86.213.121])
        by smtp12 (Coremail) with SMTP id EMCowACnqU3I1+JfA5DzTA--.36635S2;
        Wed, 23 Dec 2020 13:38:17 +0800 (CST)
Date:   Wed, 23 Dec 2020 13:38:16 +0800
From:   Hui Su <sh_def@163.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com, songmuchun@bytedance.com
Subject: Re: [PATCH] blokc/blk-merge: remove the next_bvec label in
 __blk_bios_map_sg()linux-block@vger.kernel.org (open list:BLOCK LAYER)
Message-ID: <20201223053816.GA1516634@ubuntu-A520I-AC>
References: <20201223043158.GA1502002@ubuntu-A520I-AC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223043158.GA1502002@ubuntu-A520I-AC>
X-CM-TRANSID: EMCowACnqU3I1+JfA5DzTA--.36635S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4iLL0DUUUUU
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLgoEX1SIrVE9zQAAsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all:

Please ignore this change, i will resend a patch V2 later.

