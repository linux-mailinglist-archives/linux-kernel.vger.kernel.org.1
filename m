Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99D01DA81E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 04:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgETCiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 22:38:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45806 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETCiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 22:38:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04K2cfWx037101;
        Tue, 19 May 2020 21:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589942321;
        bh=w0rb93lin9mdFPl9b4m8Fz3RZOi1CYkEm8my5Ry7GIQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AW8/FEREGVpAIDq3u1Goo41Qp1SOttZ0uwan4Q4Fqqg8Ve62C628CXRWs4D8flyx5
         tBOl/SNV7GI5uMSXvm5900m2xfkloRvhhw1cxN03sCjT6VnBPK8dFrT/m0Rdp6qfO9
         YQaKq434CjWXWB0lo8u6I9Kd9pxCZySnuqLVSoNg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04K2cfXP024106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 21:38:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 21:38:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 21:38:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04K2cfRn024519;
        Tue, 19 May 2020 21:38:41 -0500
Date:   Tue, 19 May 2020 21:38:41 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Jason Yan <yanaijie@huawei.com>
CC:     <gregkh@linuxfoundation.org>, <tony@atomide.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: use true for 'use_dma'
Message-ID: <20200520023841.GA5684@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Jason Yan <yanaijie@huawei.com>,
        gregkh@linuxfoundation.org, tony@atomide.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200426094130.23384-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200426094130.23384-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 05:41:30PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/usb/musb/musb_core.c:1798:12-19: WARNING: Assignment of 0/1 to
> bool variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Queued for v5.8. Thanks.

-Bin.
