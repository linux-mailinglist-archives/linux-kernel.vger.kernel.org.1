Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182A02D6C74
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394043AbgLKAWs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 19:22:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:2863 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391159AbgLKAWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:22:31 -0500
IronPort-SDR: rwQQgvZ3JyJ7QJxsk27fEkLXeGUKwJPe/f+UX6/u5/+p5bd0xPnoDXgt8oVQ6O3S4b7tsOlb9Y
 yqmFbs7znSbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="154164057"
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="154164057"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 16:21:51 -0800
IronPort-SDR: Mk2LrQBVgW6Am6V4nV3BxGB2HpkD2RKwlqkRU5mGWXaD2MCIn2PeqXu7KU7tpXas8gFjrKtNvM
 XrneG3exx3HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,409,1599548400"; 
   d="scan'208";a="370020062"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2020 16:21:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Dec 2020 16:21:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Dec 2020 16:21:50 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.1713.004;
 Thu, 10 Dec 2020 16:21:50 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Shuah Khan <shuah@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 00/17] Miscellaneous fixes for resctrl selftests
Thread-Topic: [PATCH v4 00/17] Miscellaneous fixes for resctrl selftests
Thread-Index: AQHWx1ZB/LSLr25VRUKkynjk//Nfh6nxGCYw
Date:   Fri, 11 Dec 2020 00:21:50 +0000
Message-ID: <684fad105f4143d4874645eddaffdbc3@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shuah,

> This patch set has several miscellaneous fixes to resctrl selftest tool that are
> easily visible to user. V1 had fixes to CAT test and CMT test but they were
> dropped in V2 because having them here made the patchset humongous. So,
> changes to CAT test and CMT test will be posted in another patchset.
> 
> Change Log:
> v4:
> - Address various comments from Shuah Khan:
>   1. Combine a few patches e.g. a couple of fixing typos patches into one
>      and a couple of unmounting patches into one etc.
>   2. Add config file.
>   3. Remove "Fixes" tags.
>   4. Change strcmp() to strncmp().
>   5. Move the global variable fixing patch to the patch 1 so that the
>      compilation issue is fixed first.

Any comment on this series?

Thank you very much for your review!

-Fenghua
