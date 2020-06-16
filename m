Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17A1FBFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 22:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgFPULW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 16:11:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:12640 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgFPULV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:11:21 -0400
IronPort-SDR: wRwJQnTM8Un/BzXDf6U3L9s4Hh32ZYuvKLzz1Ao8MwahcwS4EuSJFTVxSvx6keT0SqFbT22A9H
 3KzQEvjzLu8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:11:19 -0700
IronPort-SDR: 6JJFjwx5U8zFyHHBAO0Ktk49ER0w8YSpuZZI3n9Lrv/tHz5+aLp079gdNEbH4SzOvwU2In+dqd
 XWGm9xMZmXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="449968781"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2020 13:11:09 -0700
Date:   Tue, 16 Jun 2020 23:11:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v32 00/21] Intel SGX foundations
Message-ID: <20200616201107.GD10412@linux.intel.com>
References: <20200601075218.65618-1-jarkko.sakkinen@linux.intel.com>
 <355c8c48-3dc7-5d4e-6610-390bc9188231@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355c8c48-3dc7-5d4e-6610-390bc9188231@fortanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 02:13:23PM +0200, Jethro Beekman wrote:
> Looks like we missed the boat for 5.8. Can we get this ready for 5.9?

I sincerely hope so and do my best to get there.

/Jarkko
