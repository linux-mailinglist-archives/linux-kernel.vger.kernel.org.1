Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2B2B146B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 03:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKMCr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 21:47:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37902 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKMCr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 21:47:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AD2lBnU088609;
        Thu, 12 Nov 2020 20:47:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605235631;
        bh=mXOBY88yCzIHkzYycwE6md040NSVKNk02mMoFqwUsBo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eLkfwSyaKSwdCeti1CvgYlbjQkhgSpMEuZo0IAmNpS4NzMq6e2jyc3dgArXB5hy3V
         ewwQ/up7jTcEmp/vWkbiQGr1p+j42rCHzbCDRrDdYXGRN/gd8BxHCnyVEgxKHeAv/y
         SlltV8EqBBZUysP2mQLeMRHu6qMJFg1yfdYhDlQw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AD2lBns067736
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 20:47:11 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 20:47:11 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 20:47:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AD2lApF012334;
        Thu, 12 Nov 2020 20:47:11 -0600
Date:   Thu, 12 Nov 2020 20:47:10 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <santosh.shilimkar@oracle.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: Kconfig: Drop ARM64 SoC specific configs
Message-ID: <20201113024710.kinhetju4iumhpq4@anaerobic>
References: <20201026170624.24241-1-nm@ti.com>
 <d741c4d0-9e76-99de-7081-10f3a7a5cb1a@ti.com>
 <20201026190808.im4nb32jn4rd3xhu@crayon>
 <20201112215600.npr4g24gt4tvc5tm@kahuna>
 <4b23cb5b-b1c9-34b9-2bdf-4f9c2df9ad0d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b23cb5b-b1c9-34b9-2bdf-4f9c2df9ad0d@oracle.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:59-20201112, santosh.shilimkar@oracle.com wrote:
[...]
> > 
> 
> I can apply SOC kconfig patch [1] to my soc branch. That branch with
> some additional patches am going to send up, so it should
> work. Let me know.

I think that should work, thanks.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
