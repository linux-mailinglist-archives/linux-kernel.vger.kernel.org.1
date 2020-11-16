Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD102B4606
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgKPOjK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Nov 2020 09:39:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:27237 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgKPOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:39:10 -0500
IronPort-SDR: 6DQGaiLMfdSFWYoGHyble8lrTk3Pl0NuNSKBkcx5MsQkytey5d5nvD5NhMa7RijSEWecaqv/Ru
 qRg5X2SZggJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="188798029"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="188798029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 06:39:09 -0800
IronPort-SDR: gYL1TNp0InemVJZI4EtlOLq1jl3Xfd/TzBA7Mx0ELyfeTObRaKaPbh0f1rzj6L2HIxQRgzJ9dp
 prODrFP98w9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="329695151"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2020 06:39:07 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Nov 2020 06:39:07 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Nov 2020 22:39:05 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.1713.004;
 Mon, 16 Nov 2020 22:39:04 +0800
From:   "Sang, Oliver" <oliver.sang@intel.com>
To:     Lars Poeschel <poeschel@lemonage.de>
CC:     Miguel Ojeda <ojeda@kernel.org>, lkp <lkp@intel.com>,
        Willy Tarreau <w@1wt.eu>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: RE: [LKP] Re: [auxdisplay]  b26deabb1d:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Topic: [LKP] Re: [auxdisplay]  b26deabb1d:
 BUG:kernel_NULL_pointer_dereference,address
Thread-Index: AQHWtpV8lMndfo9euk63Z8UNc8IVGanD/GsggAYQNQCAANJ/wA==
Date:   Mon, 16 Nov 2020 14:39:04 +0000
Message-ID: <b254aa1a08974f6d9525ebb9321d7472@intel.com>
References: <20201109062934.GA7739@xsang-OptiPlex-9020>
 <20201109124003.ppuzlyyy5blf3ixu@lem-wkst-02.lemonage>
 <983cc8dc58a24dd1a839e05213fb1ffb@intel.com>
 <20201116100504.tccqktcgxwn4pyqd@lem-wkst-02.lemonage>
In-Reply-To: <20201116100504.tccqktcgxwn4pyqd@lem-wkst-02.lemonage>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> It is working now and I can reproduce the error.
> Thank you!

you are welcome

