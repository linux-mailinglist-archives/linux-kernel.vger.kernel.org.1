Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31427F359
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgI3UaV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 16:30:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:24851 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3UaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:30:21 -0400
IronPort-SDR: F48IeYyoWinqLupFKSDYFhEl0U+6r0hae7r7M2GeCjXzm+tPScQETKh7lQIP3bQ5L5Xc/v8Ndb
 MvL0eB+NVuwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="180701706"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="180701706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 13:30:16 -0700
IronPort-SDR: +AhPWNhx2/qXo3uQSZ2QlvlaRaqCMkptrBN4fTTkITcvRxI2jappvFVUI8LneBHXIpTGHqWhDS
 9gYOFqT7nxuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457797102"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2020 13:30:15 -0700
Received: from lcsmsx601.ger.corp.intel.com (10.109.210.10) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Sep 2020 13:30:14 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX601.ger.corp.intel.com (10.109.210.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Sep 2020 23:30:12 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 30 Sep 2020 23:30:12 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 47/52] docs: mei.rst: fix a C expression markup
Thread-Topic: [PATCH v4 47/52] docs: mei.rst: fix a C expression markup
Thread-Index: AQHWly0r6MNRt/94V0aRzRNN6iB9NqmBon9A
Date:   Wed, 30 Sep 2020 20:30:12 +0000
Message-ID: <3d1fd098e3bf43af9144bd6c068ee9aa@intel.com>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
 <34a9c9aaf8d5f922eac76fbd66a1a20da6b80714.1601467849.git.mchehab+huawei@kernel.org>
In-Reply-To: <34a9c9aaf8d5f922eac76fbd66a1a20da6b80714.1601467849.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Sphinx 3.x doesn't allow expressions using :c:func markup:
> 
> 	./Documentation/driver-api/mei/mei.rst:41: WARNING: Unparseable
> C cross-reference: 'close(int fd)'
> 	Invalid C declaration: Expected end of definition. [error at 5]
> 	  close(int fd)
> 	  -----^
> 
> So, convert it into a :c:expr.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>

> ---
>  Documentation/driver-api/mei/mei.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/mei/mei.rst b/Documentation/driver-
> api/mei/mei.rst
> index cea0b69ec216..4f2ced4ccdc6 100644
> --- a/Documentation/driver-api/mei/mei.rst
> +++ b/Documentation/driver-api/mei/mei.rst
> @@ -38,7 +38,7 @@ Because some of the Intel ME features can change the
> system
>  configuration, the driver by default allows only a privileged
>  user to access it.
> 
> -The session is terminated calling :c:func:`close(int fd)`.
> +The session is terminated calling :c:expr:`close(fd)`.
> 
>  A code snippet for an application communicating with Intel AMTHI client:
> 
> --
> 2.26.2

