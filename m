Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2877129AC07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899825AbgJ0M1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:27:51 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:11104
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2899725AbgJ0M1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:27:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW7PqbRuQcASqqfT3IcnbwGzaqGb0+A3FnSD/rMPPRfDVQGGhczU+YTkZhlRfMKAKGwashQI5qXx0vouQhYseWRvnlLNADuFREenuoeyIdQzpUitEd7VM4nTguHo331x60zUO5iBXKxg6RTpVZoWi08Mja8yZJI0xVVmraCffRryxBdg1tZYNCzal6Rx3cAk5z9AO1fXLjVgtGlRb0Vmnju5osI+n4jRGJI9aUIGFPJgoSpXiauId0W6jZWMm3hakcMSdtQKVeU9RQayRddORNE7w8hSnPyFuJkhDrq8COPccOz0jLgcInC3Gb6IoRnnVGi1WHVQNGXWiG8VmloA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R4UWgMCwy/YJrKkczdsiSKTQWnuCPwG4EGj3ssGwPk=;
 b=EXeNkprHEsqS2Ru/LAic14VahEvXxzvVL1LJd2QYkYyPoL4YSUiIy0+1uJK/IpgcOMaeRbDujrfskqHdBcKYiBlHvWM5pFxXtiJs0y357R25JAwZcIGcOZqmJnHMwnSuit+P0LyPBQXD6cmanUHdTks68RYea99ZBzV/e/IUeVtofyuR5DOdOTavV1PVfp6E6AdHuJFKjdqoaVGHEHhqPV1uRXibpjJzkmtk5kS/TGmP8KzQ6e94mjEEMvMtCCDZdiO2Ze4BXwBqwdG2tGogv19cGiitQXCDL8WR/mA2oyY8+oUmKRuu1e+9Q1DD0fQSPBY+Hx1yyUPUWh5HVKjUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R4UWgMCwy/YJrKkczdsiSKTQWnuCPwG4EGj3ssGwPk=;
 b=U9KRG1QYsMmT/kTaBvuo+/Q673WoP4FZQUxfycXv4g94cywTiJnxX+P9SQt1hLD47D48LbL1ImAMiPzRT7JnmBKgqeC8KKnvVykR8TvAgirvTe3H8G1SmxVTNhrVlKdbpMbum19LuIj47zqB0+kw+azHWC2vec5wplec5ogpNiY=
Received: from MN2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:208:234::29)
 by DM5PR02MB2186.namprd02.prod.outlook.com (2603:10b6:3:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 12:27:44 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::f6) by MN2PR16CA0060.outlook.office365.com
 (2603:10b6:208:234::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 12:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.20 via Frontend Transport; Tue, 27 Oct 2020 12:27:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 27 Oct 2020 05:27:19 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 27 Oct 2020 05:27:19 -0700
Envelope-to: git@xilinx.com,
 TEJASP@xilinx.com,
 RAJANV@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 arnd@kernel.org
Received: from [172.30.17.110] (port=37072)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kXO4M-0008EK-3Q; Tue, 27 Oct 2020 05:27:18 -0700
Subject: Re: [PATCH] firmware: xilinx: fix out-of-bounds access
To:     Rajan Vaja <RAJANV@xilinx.com>, Arnd Bergmann <arnd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
References: <20201026155449.3703142-1-arnd@kernel.org>
 <459e03f1-2a9e-5bc4-4bf6-9a0ddf5c4a70@xilinx.com>
 <BYAPR02MB39417FEC6A86636833EF25ECB7160@BYAPR02MB3941.namprd02.prod.outlook.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzR9NaWNoYWwgU2lt
 ZWsgPG1vbnN0ckBtb25zdHIuZXU+wsGBBBMBAgArAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIe
 AQIXgAIZAQUCWq+GEgUJDuRkWQAKCRA3fH8h/j0fkW9/D/9IBoykgOWah2BakL43PoHAyEKb
 Wt3QxWZSgQjeV3pBys08uQDxByChT1ZW3wsb30GIQSTlzQ7juacoUosje1ygaLHR4xoFMAT9
 L6F4YzZaPwW6aLI8pUJad63r50sWiGDN/UlhvPrHa3tinhReTEgSCoPCFg3TjjT4nI/NSxUS
 5DAbL9qpJyr+dZNDUNX/WnPSqMc4q5R1JqVUxw2xuKPtH0KI2YMoMZ4BC+qfIM+hz+FTQAzk
 nAfA0/fbNi0gi4050wjouDJIN+EEtgqEewqXPxkJcFd3XHZAXcR7f5Q1oEm1fH3ecyiMJ3ye
 Paim7npOoIB5+wL24BQ7IrMn3NLeFLdFMYZQDSBIUMe4NNyTfvrHPiwZzg2+9Z+OHvR9hv+r
 +u/iQ5t5IJrnZQIHm4zEsW5TD7HaWLDx6Uq/DPUf2NjzKk8lPb1jgWbCUZ0ccecESwpgMg35
 jRxodat/+RkFYBqj7dpxQ91T37RyYgSqKV9EhkIL6F7Whrt9o1cFxhlmTL86hlflPuSs+/Em
 XwYVS+bO454yo7ksc54S+mKhyDQaBpLZBSh/soJTxB/nCOeJUji6HQBGXdWTPbnci1fnUhF0
 iRNmR5lfyrLYKp3CWUrpKmjbfePnUfQS+njvNjQG+gds5qnIk2glCvDsuAM1YXlM5mm5Yh+v
 z47oYKzXe87A4gRRb3+lEQQAsBOQdv8t1nkdEdIXWuD6NPpFewqhTpoFrxUtLnyTb6B+gQ1+
 /nXPT570UwNw58cXr3/HrDml3e3Iov9+SI771jZj9+wYoZiO2qop9xp0QyDNHMucNXiy265e
 OAPA0r2eEAfxZCi8i5D9v9EdKsoQ9jbII8HVnis1Qu4rpuZVjW8AoJ6xN76kn8yT225eRVly
 PnX9vTqjBACUlfoU6cvse3YMCsJuBnBenGYdxczU4WmNkiZ6R0MVYIeh9X0LqqbSPi0gF5/x
 D4azPL01d7tbxmJpwft3FO9gpvDqq6n5l+XHtSfzP7Wgooo2rkuRJBntMCwZdymPwMChiZgh
 kN/sEvsNnZcWyhw2dCcUekV/eu1CGq8+71bSFgP/WPaXAwXfYi541g8rLwBrgohJTE0AYbQD
 q5GNF6sDG/rNQeDMFmr05H+XEbV24zeHABrFpzWKSfVy3+J/hE5eWt9Nf4dyto/S55cS9qGB
 caiED4NXQouDXaSwcZ8hrT34xrf5PqEAW+3bn00RYPFNKzXRwZGQKRDte8aCds+GHufCwa0E
 GAECAA8CGwIFAlqvhnkFCQ7joU8AUgkQN3x/If49H5FHIAQZEQIABgUCUW9/pQAKCRDKSWXL
 KUoMITzqAJ9dDs41goPopjZu2Au7zcWRevKP9gCgjNkNe7MxC9OeNnup6zNeTF0up/nEYw/9
 Httigv2cYu0Q6jlftJ1zUAHadoqwChliMgsbJIQYvRpUYchv+11ZAjcWMlmW/QsS0arrkpA3
 RnXpWg3/Y0kbm9dgqX3edGlBvPsw3gY4HohkwptSTE/h3UHS0hQivelmf4+qUTJZzGuE8TUN
 obSIZOvB4meYv8z1CLy0EVsLIKrzC9N05gr+NP/6u2x0dw0WeLmVEZyTStExbYNiWSpp+SGh
 MTyqDR/lExaRHDCVaveuKRFHBnVf9M5m2O0oFlZefzG5okU3lAvEioNCd2MJQaFNrNn0b0zl
 SjbdfFQoc3m6e6bLtBPfgiA7jLuf5MdngdWaWGti9rfhVL/8FOjyG19agBKcnACYj3a3WCJS
 oi6fQuNboKdTATDMfk9P4lgL94FD/Y769RtIvMHDi6FInfAYJVS7L+BgwTHu6wlkGtO9ZWJj
 ktVy3CyxR0dycPwFPEwiRauKItv/AaYxf6hb5UKAPSE9kHGI4H1bK2R2k77gR2hR1jkooZxZ
 UjICk2bNosqJ4Hidew1mjR0rwTq05m7Z8e8Q0FEQNwuw/GrvSKfKmJ+xpv0rQHLj32/OAvfH
 L+sE5yV0kx0ZMMbEOl8LICs/PyNpx6SXnigRPNIUJH7Xd7LXQfRbSCb3BNRYpbey+zWqY2Wu
 LHR1TS1UI9Qzj0+nOrVqrbV48K4Y78sajt7OwU0EUW68MQEQAJeqJfmHggDTd8k7CH7zZpBZ
 4dUAQOmMPMrmFJIlkMTnko/xuvUVmuCuO9D0xru2FK7WZuv7J14iqg7X+Ix9kD4MM+m+jqSx
 yN6nXVs2FVrQmkeHCcx8c1NIcMyr05cv1lmmS7/45e1qkhLMgfffqnhlRQHlqxp3xTHvSDiC
 Yj3Z4tYHMUV2XJHiDVWKznXU2fjzWWwM70tmErJZ6VuJ/sUoq/incVE9JsG8SCHvVXc0MI+U
 kmiIeJhpLwg3e5qxX9LX5zFVvDPZZxQRkKl4dxjaqxAASqngYzs8XYbqC3Mg4FQyTt+OS7Wb
 OXHjM/u6PzssYlM4DFBQnUceXHcuL7G7agX1W/XTX9+wKam0ABQyjsqImA8u7xOw/WaKCg6h
 JsZQxHSNClRwoXYvaNo1VLq6l282NtGYWiMrbLoD8FzpYAqG12/z97T9lvKJUDv8Q3mmFnUa
 6AwnE4scnV6rDsNDkIdxJDls7HRiOaGDg9PqltbeYHXD4KUCfGEBvIyx8GdfG+9yNYg+cFWU
 HZnRgf+CLMwN0zRJr8cjP6rslHteQYvgxh4AzXmbo7uGQIlygVXsszOQ0qQ6IJncTQlgOwxe
 +aHdLgRVYAb5u4D71t4SUKZcNxc8jg+Kcw+qnCYs1wSE9UxB+8BhGpCnZ+DW9MTIrnwyz7Rr
 0vWTky+9sWD1ABEBAAHCwWUEGAECAA8CGwwFAlqvhmUFCQ7kZLEACgkQN3x/If49H5H4OhAA
 o5VEKY7zv6zgEknm6cXcaARHGH33m0z1hwtjjLfVyLlazarD1VJ79RkKgqtALUd0n/T1Cwm+
 NMp929IsBPpC5Ql3FlgQQsvPL6Ss2BnghoDr4wHVq+0lsaPIRKcQUOOBKqKaagfG2L5zSr3w
 rl9lAZ5YZTQmI4hCyVaRp+x9/l3dma9G68zY5fw1aYuqpqSpV6+56QGpb+4WDMUb0A/o+Xnt
 R//PfnDsh1KH48AGfbdKSMI83IJd3V+N7FVR2BWU1rZ8CFDFAuWj374to8KinC7BsJnQlx7c
 1CzxB6Ht93NvfLaMyRtqgc7Yvg2fKyO/+XzYPOHAwTPM4xrlOmCKZNI4zkPleVeXnrPuyaa8
 LMGqjA52gNsQ5g3rUkhp61Gw7g83rjDDZs5vgZ7Q2x3CdH0mLrQPw2u9QJ8K8OVnXFtiKt8Q
 L3FaukbCKIcP3ogCcTHJ3t75m4+pwH50MM1yQdFgqtLxPgrgn3U7fUVS9x4MPyO57JDFPOG4
 oa0OZXydlVP7wrnJdi3m8DnljxyInPxbxdKGN5XnMq/r9Y70uRVyeqwp97sKLXd9GsxuaSg7
 QJKUaltvN/i7ng1UOT/xsKeVdfXuqDIIElZ+dyEVTweDM011Zv0NN3OWFz6oD+GzyBetuBwD
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <8a632786-eb40-ea00-2b98-2d494fabb06f@xilinx.com>
Date:   Tue, 27 Oct 2020 13:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB39417FEC6A86636833EF25ECB7160@BYAPR02MB3941.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf6714e1-4d9d-4410-a181-08d87a73b4c3
X-MS-TrafficTypeDiagnostic: DM5PR02MB2186:
X-Microsoft-Antispam-PRVS: <DM5PR02MB21869066BCD5A2F521AB3A63C6160@DM5PR02MB2186.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VucrqkQuacPPRxs/lY4yZ4/2yex/RXbbdeg9OBGNMOl548Lw0xAnPRAOI6ZDh1a3EsZHY17Xzzmw5ngCpQguhvxAaEfStrHEP7ku5l5+7Is4A9MssEDtw+HTVFykAWoMc25YZUNXyOnfRsqRGcdMnIANM5KiaYcRhCaj/OkxU8Ay5Ajwx8whfnGu4HEW7Mw/lYBDX/Ctw4MaYlC4AQLF5jMPrfVujYglwVVFRdKo6DhIr4fAyOpbXfyVc91TR85ArsEDgfW7c0oNIhvUGHwlxGAe5C7wWtLQ8fQq1JzwHcNAcpIxPXeE3vjO77hIo6fpq0z5ViLgWKyOCUWml7lnUvPWRAsteYwTieGH0z/YOY7QjRpQQ85pyur+qdX0mG0DlVHATe5Ut8zeKnZTS6v+0TiRO7uiTgG3XMKIoPvyZWOZixfZYRlh1T03c/66SgPEX6aD6oZpNLaqQC6xFsOCQw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966005)(31686004)(6666004)(110136005)(426003)(44832011)(186003)(31696002)(5660300002)(36906005)(54906003)(53546011)(9786002)(2616005)(107886003)(316002)(26005)(336012)(2906002)(70206006)(356005)(7636003)(70586007)(82310400003)(4326008)(478600001)(8676002)(36756003)(47076004)(82740400003)(8936002)(83380400001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 12:27:44.4063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6714e1-4d9d-4410-a181-08d87a73b4c3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2186
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27. 10. 20 13:23, Rajan Vaja wrote:
> Hi Michal,
> 
>> -----Original Message-----
>> From: Michal Simek <michal.simek@xilinx.com>
>> Sent: 27 October 2020 02:53
>> To: Arnd Bergmann <arnd@kernel.org>; Michal Simek <michals@xilinx.com>;
>> Rajan Vaja <RAJANV@xilinx.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>; Rajan Vaja <RAJANV@xilinx.com>; Greg
>> Kroah-Hartman <gregkh@linuxfoundation.org>; Tejas Patel
>> <TEJASP@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; git <git@xilinx.com>
>> Subject: Re: [PATCH] firmware: xilinx: fix out-of-bounds access
>>
>>
>>
>> On 26. 10. 20 16:54, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The zynqmp_pm_set_suspend_mode() and
>> zynqmp_pm_get_trustzone_version()
>>> functions pass values as api_id into zynqmp_pm_invoke_fn
>>> that are beyond PM_API_MAX, resulting in an out-of-bounds access:
>>>
>>> drivers/firmware/xilinx/zynqmp.c: In function
>> 'zynqmp_pm_set_suspend_mode':
>>> drivers/firmware/xilinx/zynqmp.c:150:24: warning: array subscript 2562 is above
>> array bounds of 'u32[64]' {aka 'unsigned int[64]'} [-Warray-bounds]
>>>   150 |  if (zynqmp_pm_features[api_id] != PM_FEATURE_UNCHECKED)
>>>       |      ~~~~~~~~~~~~~~~~~~^~~~~~~~
>>> drivers/firmware/xilinx/zynqmp.c:28:12: note: while referencing
>> 'zynqmp_pm_features'
>>>    28 | static u32 zynqmp_pm_features[PM_API_MAX];
>>>       |            ^~~~~~~~~~~~~~~~~~
>>
>> Which CONFIG option/tool is reporting this issue?
>>
>>>
>>> Replace the resulting undefined behavior with an error return.
>>> This may break some things that happen to work at the moment
>>> but seems better than randomly overwriting kernel data.
>>>
>>> I assume we need additional fixes for the two functions that now
>>> return an error.
>>>
>>> Fixes: 76582671eb5d ("firmware: xilinx: Add Zynqmp firmware driver")
>>> Fixes: e178df31cf41 ("firmware: xilinx: Implement ZynqMP power management
>> APIs")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/firmware/xilinx/zynqmp.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/firmware/xilinx/zynqmp.c
>> b/drivers/firmware/xilinx/zynqmp.c
>>> index 8d1ff2454e2e..efb8a66efc68 100644
>>> --- a/drivers/firmware/xilinx/zynqmp.c
>>> +++ b/drivers/firmware/xilinx/zynqmp.c
>>> @@ -147,6 +147,9 @@ static int zynqmp_pm_feature(u32 api_id)
>>>  		return 0;
>>>
>>>  	/* Return value if feature is already checked */
>>> +	if (api_id > ARRAY_SIZE(zynqmp_pm_features))
>>> +		return PM_FEATURE_INVALID;
>>> +
>>>  	if (zynqmp_pm_features[api_id] != PM_FEATURE_UNCHECKED)
>>>  		return zynqmp_pm_features[api_id];
>>>
>>>
>>
>> Definitely good catch but not quite sure what should be correct reaction.
>> Rajan: Can you please take a look at it with priority?
> [Rajan] Change looks fine to me.

as is mentioned above that two functions now returns and error
PM_FEATURE_INVALID. Which means that zynqmp_pm_set_suspend_mode() and
zynqmp_pm_get_trustzone_version() fail all the time which doesn't look
correct.

M
