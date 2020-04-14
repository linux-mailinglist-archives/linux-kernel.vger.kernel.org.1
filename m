Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4F1A702C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 02:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbgDNAcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 20:32:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:15737 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390458AbgDNAcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 20:32:07 -0400
IronPort-SDR: EYMp1SJoWnYFE8rjykcnBOL8OK1eZ0A6hSBY//KAQRZa9KG8HjDBPowk/4iH7XMMFkYtGr+s9g
 7imc+LzrVVBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 17:32:06 -0700
IronPort-SDR: 3QfILJpHAcg1gY9oSJ3+Ydms7rXbbNc3LHpLjIZ0fVRGGQBuquF5Zn7yR5TSu526LbdaM8dYg7
 f1JgFUaAppJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="363222694"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2020 17:32:05 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A2F593018EA; Mon, 13 Apr 2020 17:32:05 -0700 (PDT)
Date:   Mon, 13 Apr 2020 17:32:05 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20200414003205.GF397326@tassilo.jf.intel.com>
References: <1570212969-21888-1-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1911151926380.28787@nanos.tec.linutronix.de>
 <20191115191200.GD22747@tassilo.jf.intel.com>
 <A78C989F6D9628469189715575E55B236B50834A@IRSMSX104.ger.corp.intel.com>
 <CALCETrXc=-k3fQyxjBok0npjTMr6-Ho7+pkvzDUdG=b52Qz=9g@mail.gmail.com>
 <A78C989F6D9628469189715575E55B236B508C1A@IRSMSX104.ger.corp.intel.com>
 <CALCETrWb9jvwOPuupet4n5=JytbS-x37bnn=THniv_d8cNvf_Q@mail.gmail.com>
 <29FD6626-4347-4B79-A027-52E44C7FDE55@intel.com>
 <20200413200336.GA11216@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413200336.GA11216@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is my attempt at understanding the current situation correct?

Yes.

Nothing breaks, and it's a nice improvement for context switch
performance, in NMI/PMU performance, and also gives user space two free
registers to play around with.

-Andi
