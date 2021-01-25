Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90002302CED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbhAYUuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:50:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:33913 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732309AbhAYUsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:48:21 -0500
IronPort-SDR: tbRosZnG2pLgJHTysrEhHuSYLPbNoArc/fompC5mJhkLMQrhrC00oCWzeHM+Z0O2r5YB+bwkoG
 xZaopvDkHhUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179944582"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="179944582"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 12:47:40 -0800
IronPort-SDR: OWPDduKFZGFtNNHisO5QDD6Qi3l1CfYWvwGxi/1KcUhp54+NFCfyw3VbDRi6PswzC5fxLu9rPt
 JpQjE9O7leiA==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="361672727"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 12:47:40 -0800
Date:   Mon, 25 Jan 2021 20:47:33 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/17] Miscellaneous fixes for resctrl selftests
Message-ID: <YA8uZYiGFzee+UHD@otcwcpicx3.sc.intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shuah,

On Mon, Nov 30, 2020 at 08:19:53PM +0000, Fenghua Yu wrote:
> This patch set has several miscellaneous fixes to resctrl selftest tool
> that are easily visible to user. V1 had fixes to CAT test and CMT test
> but they were dropped in V2 because having them here made the patchset
> humongous. So, changes to CAT test and CMT test will be posted in another
> patchset.
> 
> Change Log:
> v4:
> - Address various comments from Shuah Khan:
>   1. Combine a few patches e.g. a couple of fixing typos patches into one
>      and a couple of unmounting patches into one etc.

Just a friendly reminder. Will you push this series to the upstream?
Maybe I miss something but I don't see this series in the linux-kselftest
tree yet.

Thank you very much!

-Fenghua
