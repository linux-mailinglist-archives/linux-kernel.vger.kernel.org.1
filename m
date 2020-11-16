Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885C62B3F42
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgKPI5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:57:31 -0500
Received: from mail-am6eur05on2116.outbound.protection.outlook.com ([40.107.22.116]:13377
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbgKPI5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:57:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqFMujluC4+O+8vVvlUhTo+FuwcO67sZhl7HXvCaH9cWRWtKT0gK0d2KHBLEfuJ6sRRr0OONtzMq/5QR39cQ6PxHQhCzG7qzIoJWVnv8JJgXjAUV3XyGfKMym2+UwzQewPq9rlhOmWbTXkE7w+Vh4FpZvZx5mHPs5jNF0WPwqyCQN//duDSyCweQvS5ocQapLfrAXSPjpWhFFbmA43sE0MNVDrpPdmomVXFSYadf0WKhFxVJiCVJVsUJD8gDRfu42dLZfALruodp4j+SFff4yDB/ufKnvFr7vpXPG4l6ka0+mfVeLQ2so9D4gv3Nri7/1016JcUVo/aX6l2E/qP9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb1mYEH6RieZNFdbTWVSUF50n4VJM1Gg9ilylfzVafw=;
 b=Ys/deUSSXRPGrW0PSQInno+CRz45Z/8tsERQI2Br5727Zo9daJ9j+NFIRhJu0qcw5CHEthrf+g4MabMInyVaKvewmaOiPw+wbthM+rKT1xRhHfuBC/iKBBWqazUlDoqo0jkG0plEachOQderdiLqx6MHSl3RnrrUgK10qNUCcjnT2jA2UKqjtDUdpAOz1tt3C0NoJg78X8ACTRnHQ0VFMu0jh+SaJKUsz9y/WR4gyApg80QW+xsY6ALYLPJT5t5y8hdMRgrmGW6s0MlB7RhVjsyt+IKVAeYAYlZSS/Ubq2b6H36fyymFhRPZivjNOAI9T/cDqmre+MxhFSY1QRQNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb1mYEH6RieZNFdbTWVSUF50n4VJM1Gg9ilylfzVafw=;
 b=SqzPcLihILhRuJO5r7CIPjOsJTZP7fRgWX88o0aqBUplmZ5M5j9Uq22A1CmF1QQE4LGcds4IDHbsMFOGJ8sgZ0iQqzZuhEESL494rETBqctzf1oswcRJYnnNmU9fPna5uLs/bvQSVbzxAFElGD/GPWWa4oud/KX0dQbqmwvDT+Q=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB4404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 08:57:28 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 08:57:28 +0000
Subject: Re: Antw: [EXT] [systemd-devel] [SPECIFICATION RFC] The firmware and
 bootloader log specification
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        coreboot@coreboot.org, grub-devel@gnu.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org,
        u-boot@lists.denx.de,
        "systemd-devel@lists.freedesktop.org" 
        <systemd-devel@lists.freedesktop.org>,
        xen-devel@lists.xenproject.org, daniel.kiper@oracle.com,
        linux-kernel@vger.kernel.org
Cc:     krystian.hebel@3mdeb.com, michal.zygowski@3mdeb.com,
        piotr.krol@3mdeb.com, mtottenh@akamai.com, luto@amacapital.net,
        dpsmith@apertussolutions.com, andrew.cooper3@citrix.com,
        roger.pau@citrix.com, allen.cryptic@gmail.com, btrotter@gmail.com,
        phcoder@gmail.com, lukasz.hawrylko@intel.com,
        ard.biesheuvel@linaro.org, tyhicks@linux.microsoft.com,
        pmenzel@molgen.mpg.de, hun@n-dimensional.de, leif@nuviainc.com,
        alexander.burmashev@oracle.com, eric.devolder@oracle.com,
        eric.snowberg@oracle.com, joao.m.martins@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        ross.philipson@oracle.com, javierm@redhat.com, pjones@redhat.com,
        alecb@umass.edu, "H. Peter Anvin" <hpa@zytor.com>
References: <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>
 <5FB223E8020000A10003CB88@gwsmtp.uni-regensburg.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <2d920ff2-68cb-69f5-f2d9-47131ec1b512@prevas.dk>
Date:   Mon, 16 Nov 2020 09:57:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5FB223E8020000A10003CB88@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [5.186.115.188]
X-ClientProxiedBy: AM5PR0701CA0070.eurprd07.prod.outlook.com
 (2603:10a6:203:2::32) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.115.188) by AM5PR0701CA0070.eurprd07.prod.outlook.com (2603:10a6:203:2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Mon, 16 Nov 2020 08:57:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51df6655-3ee2-480b-88ea-08d88a0da4d0
X-MS-TrafficTypeDiagnostic: AM9PR10MB4404:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4404A174825A369F20F04BBC93E30@AM9PR10MB4404.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hu4BhxR9oCJwEru+vqpQVtzm7o52z+tCM7zAnzWlKgMRJFFOuAulwMYUzKqtQZ7AR2LZzxCts8yBLwW8yfOx+5B1ccyxoUGLEXm+bMdDnmN4X1IlGYMJN/Ouaiq3VxhkpRtevgP2C89qdsmrS2FgTnLH+rkrEZXtKbJvygGtT+ym0+S/kcrcn4BqTHndyCupJVZQu9YASYurpBG5w6efTob2tN3ZMrDmcIhJoC7DFgGSV6T00LTmmURpdXC2xrZb73QQdAsSwN+9ExVq8/9Cd2bZu3DSCAQPZ+qV0O/XeTbYZZdcvWIDMk12Z6eDQvhAiemCGz1LvintrJ9mm5NkJG4kU5qnGi57j+vGUYMjFtYrzTMAdAQFfjELo1AoP0qSEl8euhF7FfXQjSbeT20/Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39840400004)(110136005)(6486002)(478600001)(5660300002)(2906002)(16576012)(8676002)(316002)(31696002)(86362001)(44832011)(66946007)(66476007)(66556008)(36756003)(2616005)(956004)(7416002)(83380400001)(7406005)(4326008)(31686004)(8936002)(921005)(16526019)(8976002)(186003)(52116002)(26005)(4744005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UWzoybq3nNTkbbTk8hr9AtM6lC67kIrU1czuB9edRIVc4u759capC7V4HQW7GfcnqoBUek0lgwL+EK0tlFRiB6LJRoxID5P6ks1iP74HPqwrnpRWTeUaeh1G/U/OuBYSH4hjyYOaAB2xn69pnNNDTl0Xl2H5pnph6eGNdh1h7vzTnLcHt/I089enW1BopLG4Ftk3HQkEGU8RqQ7akO8SjZ+JyPBrEBSPgBRheiftJpWxogObGPh7zTmkrFYaJHWwKZ+21w9ItNv1Iklwv2KkkPc2KDrs25Xs6uQaZVeCHF6bHebwLGWb8qoyy+qpvsqFIPVbFAn8cSXkaf94aa6FEOfBoaWG+kx50Po+z1nGuNkILyEQtIsBgW732s1AWuKnKWFK8mNCZtn4J9tnBa4dLmVabpuucyqqHjIGE+0xKHNsUm/pRnpP7ZpF4A69LLycXkNu0vQ73rqKlMKwUJCf2R/A1aRlwhTa9druJqRP0FX2gb80sxtkTt9/GWBUV+mZ9HYOtjWcLugxQeKfaJWz1zvj42mFqyAie93ETPSnBE4KhZrnUfksV84ezwVCkdKNf+MC/NuqqXEDebR29cf7G78S+czGMztr/+PmyjKoTVRU96bsz2lmRcoAAEZmlYkrCS4yQtoOJgHtEGJSUR1g9Q==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 51df6655-3ee2-480b-88ea-08d88a0da4d0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 08:57:28.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmGFQ99hS0Z5oBfPElVCfR+/nsMklXhz+Y0C2IZYwtZegDmUt78DCbFctVhWLG8zVFJBKvQc4iAq3GwhYZySGDo4PFskOBKd6Osed0Yhfbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4404
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2020 08.02, Ulrich Windl wrote:
>>>> Daniel Kiper <daniel.kiper@oracle.com> schrieb am 14.11.2020 um 00:52 in
> Nachricht <20201113235242.k6fzlwmwm2xqhqsi@tomti.i.net-space.pl>:
> ...
>> The members of struct bf_log_msg:
>>   ‑ size: total size of bf_log_msg struct,
>>   ‑ ts_nsec: timestamp expressed in nanoseconds starting from 0,
> 
> Who or what defines t == 0?

Some sort of "clapperboard" log entry, stating "the RTC says X, the
cycle counter is Y, the onboard ACME atomic clock says Z, I'm now
starting to count ts_nsec from W" might be useful for some eventual
userspace tool to try to stitch together the log entries from the
various stages. I have no idea how a formal spec of such an entry would
look like or if it's even feasible to do formally. But even just such
entries in free-form prose could at least help a human consumer.

Rasmus
