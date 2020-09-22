Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD72747FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVSLK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Sep 2020 14:11:10 -0400
Received: from smtp.h3c.com ([60.191.123.56]:15152 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVSLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:11:10 -0400
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 08MFVQZ3069235
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 23:31:26 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
        by h3cspam01-ex.h3c.com with ESMTPS id 08MFRMLE067100
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 23:27:22 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 23:27:27 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Tue, 22 Sep 2020 23:27:27 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Thread-Topic: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
Thread-Index: AQHWkKof6KH2tOMk4EuCjM46q9dNfal0OdSAgAAAdACAAI18gA==
Date:   Tue, 22 Sep 2020 15:27:27 +0000
Message-ID: <5099986543624f9fbbeb26c2173934ba@h3c.com>
References: <20200922062517.30031-1-tian.xianting@h3c.com>
 <20200922145705.GA4035426@dhcp-10-100-145-180.wdl.wdc.com>
 <20200922145842.GB28420@lst.de>
In-Reply-To: <20200922145842.GB28420@lst.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08MFRMLE067100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Keith, Christoph,
So I don't need to send v3 patch? 

-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Tuesday, September 22, 2020 10:59 PM
To: Keith Busch <kbusch@kernel.org>
Cc: tianxianting (RD) <tian.xianting@h3c.com>; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking whether req is null

On Tue, Sep 22, 2020 at 07:57:05AM -0700, Keith Busch wrote:
> The commit subject is a too long. We should really try to keep these 
> to
> 50 characters or less.
> 
>   nvme-pci: fix NULL req in completion handler
> 
> Otherwise, looks fine.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Yes.  I was about to apply it with a similar edit, but I'll take yours happily.
