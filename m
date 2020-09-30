Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5DD27E92C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgI3NFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:05:36 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48982 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728149AbgI3NFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:05:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7E7804130F;
        Wed, 30 Sep 2020 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1601471133; x=1603285534; bh=uRgOOz6gHkYkqhMht+S6AJQ3u
        C1j/85HK5iKpP3tN3Q=; b=WDQAU01VhkwskLwjKCmu5k7pLrOTQQo2YVqpfdiUc
        OxDYf8jfLMRu+ekuVnpjfzOmDMBLRUyqtCjvi16vnhEiBcfFFBx8Yp/e0ozmyFxz
        JLXE7y8cV2FgwgkvGm4FuKDhEbZcVIV/Ac2N+s+jbGQLe1YHD14SeG1TWUzw2wTJ
        ho=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nOafVfGaIrNy; Wed, 30 Sep 2020 16:05:33 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 7384441207;
        Wed, 30 Sep 2020 16:05:33 +0300 (MSK)
Received: from localhost.localdomain (10.199.2.122) by
 T-EXCH-04.corp.yadro.com (172.17.100.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 30 Sep 2020 16:05:32 +0300
Message-ID: <f6d82a7a3411aed1f72f1ff3bb5f84426c44bda1.camel@yadro.com>
Subject: Re: [RESEND PATCH 2/2] mtd: spi-nor: enable lock interface for
 macronix chips
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Sep 2020 16:09:32 +0300
In-Reply-To: <cb47d79f-ecbb-f0ec-388e-b56ba740045e@ti.com>
References: <20200921112450.4824-1-i.mikhaylov@yadro.com>
         <20200921112450.4824-3-i.mikhaylov@yadro.com>
         <cb47d79f-ecbb-f0ec-388e-b56ba740045e@ti.com>
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

On Wed, 2020-09-30 at 15:10 +0530, Vignesh Raghavendra wrote:
> Hi,
> 
> On 9/21/20 4:54 PM, Ivan Mikhaylov wrote:
> > Add locks for whole macronix chip series with BP0-2 and BP0-3 bits.
> > 
> > Tested with mx25l51245g(BP0-3).
> 
> Since you have only tested on flash that have 4bit BP, please don't
> modify flashes that have 3bit BP. Lets be conservative and enable only
> things that have been tested else we may end up with broken feature from
> day 1.
> 

Sure, will do then this way.

Thanks.

