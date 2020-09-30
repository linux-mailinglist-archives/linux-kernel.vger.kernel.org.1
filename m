Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0727E92A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgI3NEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:04:06 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48894 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbgI3NED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:04:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id E7FD14130F;
        Wed, 30 Sep 2020 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1601471040; x=1603285441; bh=njVa9cplwqkKacO5snuH36/Bo
        YnsXd9WkIp7KVh22W4=; b=DzYrn8U4Ujk/W1+h6DsWmSjEeguylOsSX2hS2dMPA
        4ePHPgmlTkpCQF+NH1q3Iw+7GyPrYCJ6eCIYl8MAwTRX/RdYCn0BPQ88qWRQfk/T
        bD3pdGK35uKUIu0XgL88EZpNNjKCoB6unKJ5qvJnAxbqgKDY2XFzTJwtfcoeHV3B
        +U=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dvIGsKiEPSWw; Wed, 30 Sep 2020 16:04:00 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C084041207;
        Wed, 30 Sep 2020 16:04:00 +0300 (MSK)
Received: from localhost.localdomain (10.199.2.122) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 30 Sep 2020 16:04:00 +0300
Message-ID: <4a5945534f7b41cb799c044ec8c9d31c61d5beda.camel@yadro.com>
Subject: Re: [RESEND PATCH 1/2] mtd: spi-nor: do not touch TB bit without
 SPI_NOR_HAS_TB
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Sep 2020 16:07:53 +0300
In-Reply-To: <9bfb10df-64d8-4a5e-b0ad-a8b5f4efc56f@ti.com>
References: <20200921112450.4824-1-i.mikhaylov@yadro.com>
         <20200921112450.4824-2-i.mikhaylov@yadro.com>
         <9bfb10df-64d8-4a5e-b0ad-a8b5f4efc56f@ti.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.2.122]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 15:06 +0530, Vignesh Raghavendra wrote:
> 
> On 9/21/20 4:54 PM, Ivan Mikhaylov wrote:
> > Some chips like macronix don't have TB(Top/Bottom protection)
> > bit in the status register. Do not write tb_mask inside status
> > register, unless SPI_NOR_HAS_TB is present for the chip.
> > 
> 
> Not entirely accurate.. Macronix chips have TB bit in config register
> and is OTP and hence should not be touched ideally...
> 
> You still need to "read" that bit to determine actual scheme (Top vs
> Bottom). This is needs to be done before 2/2 enables SPI_NOR_HAS_LOCK
> flag for macronix flashes.

Vignesh, that's the point about this commit to generalize this part about TB bit
plus there is already exist SPI_NOR_HAS_TB flag which representing state of TB
existence. I didn't add any support for macronix's TB bit, that's true but
that's enough to make macronix chips able to use lock mechanism with default
'use_top' or any other chips which doesn't have TB bit.

> I guess macronix does not support SR_SRWD right? This needs special
> treatment as well.

It does support SR_SRWD as well. No need any special treatment here.

Thanks.

