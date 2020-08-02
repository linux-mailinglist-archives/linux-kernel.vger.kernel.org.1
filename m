Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6A2357A4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHBOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 10:37:23 -0400
Received: from zg8tmtm5lju5ljm3lje2naaa.icoremail.net ([139.59.37.164]:44496
        "HELO zg8tmtm5lju5ljm3lje2naaa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725778AbgHBOhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:37:22 -0400
Received: from [101.5.209.60] (unknown [101.5.209.60])
        by app-1 (Coremail) with SMTP id DwQGZQDHzalQzyZf+jXrAw--.8461S2;
        Sun, 02 Aug 2020 22:36:02 +0800 (CST)
From:   Jia-Ju Bai <baijiaju@tsinghua.edu.cn>
Subject: [BUG] crypto: qat: accessing the data mapped to streaming DMA
To:     giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, horia.geanta@nxp.com,
        geert+renesas@glider.be, ebiggers@google.com
Cc:     qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <7bda4db1-cca2-f6f1-4b70-52d2d25f8d2d@tsinghua.edu.cn>
Date:   Sun, 2 Aug 2020 22:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DwQGZQDHzalQzyZf+jXrAw--.8461S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYH7k0a2IF6FyUM7kC6x804xWl14x267AK
        xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj
        6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF
        7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6ry5MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zBTUUUUUU==
X-CM-SenderInfo: xedlyxhdmxq3pvlqwxlxdovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qat_alg_sgl_to_bufl(), "bufl" and "buflout" are mapped to streaming DMA:
   blp = dma_map_single(dev, bufl, sz, DMA_TO_DEVICE);
   bloutp = dma_map_single(dev, buflout, sz_out, DMA_TO_DEVICE);

Then "bufl" and "buflout" are accessed at some places, such as:
   bufl->bufers[y].len = sg->length;
   bufl->num_bufs = sg_nctr;
   bufers = buflout->bufers;
   buflout->num_bufs = sg_nctr;

These accesses may cause data inconsistency between CPU cache and hardware.

I am not sure how to properly fix this problem, and thus I only report it.


Best wishes,
Jia-Ju Bai

