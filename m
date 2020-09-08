Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D637F261F3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbgIHUBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:01:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48278 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgIHPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088C3VsW004198;
        Tue, 8 Sep 2020 07:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599566611;
        bh=nsqPY6o4grvE2pz2lannxuY5WsjPIahg4+RoCYp/mc4=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ia2HCvqTdT2aSCL0/porgUy55z/i+UNq4fGm51IBwnjCi49OkizTxLE8QrQf5pLhG
         tNYc8imMXyJknGPW8h8Bjtcf/u01AeRfbs9KUtXdyT/+siXEYWnKXnxY9GGFMd0Cgj
         bZSQ1blN0Ra3RX6g1cY8xR/cDa84TcLT/G/RdfnA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088C3V75118701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 07:03:31 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 07:03:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 07:03:31 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088C3SxG114548;
        Tue, 8 Sep 2020 07:03:29 -0500
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Avoid accessing invalid
 gpio_reset
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>, Camel Guo <camelg@axis.com>
References: <20200908083521.14105-1-camel.guo@axis.com>
 <7bb93489-dbd5-d1a5-5df6-e62470bd2252@ti.com>
X-Pep-Version: 2.0
Message-ID: <e791162b-1292-e1c4-3fca-b8936beeeb45@ti.com>
Date:   Tue, 8 Sep 2020 15:03:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7bb93489-dbd5-d1a5-5df6-e62470bd2252@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


