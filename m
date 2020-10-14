Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3992928E86D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgJNVeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:34:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:38647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgJNVeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:34:14 -0400
IronPort-SDR: 6gK3BuNwnZiwIetnG8/SVVc+/ykuai45W9kufI16kvlWgJDeyMixQyF7GFl3KcNSLLP7ieBvKP
 U8hIs0xCYcHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="166318477"
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400"; 
   d="scan'208";a="166318477"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 14:34:11 -0700
IronPort-SDR: rOHH2s/plb6wYNVJ8lblp0P0nyOJJnYBb7ixCTLY+e+2L7+qNHQyYNq+XYXAl1NgTytfMdl60x
 Qv6jLZWB5+Pw==
X-IronPort-AV: E=Sophos;i="5.77,376,1596524400"; 
   d="scan'208";a="464034099"
Received: from wydrak-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.67])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 14:34:08 -0700
Date:   Thu, 15 Oct 2020 00:34:06 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Backing up the PGP master key
Message-ID: <20201014213406.GA7622@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin, writing to you based on 'git blame' :-)

The maintainer guide recommends using paperkey for the PGP master key,
which is a prefectly sane method.

I was just wondering that isn't a backup to a USB stick a reasonable
option? E.g. get a few USB sticks (new, unweared), store your master key
to each of them and put to safe.

/Jarkko
