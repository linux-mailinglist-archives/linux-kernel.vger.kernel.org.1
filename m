Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB7D1D7CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgERPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 11:34:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:42695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgERPeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:34:09 -0400
IronPort-SDR: OXeartJWH0bxtj2gH0kMkmvq0tVe6Qz+RjzMQIAdHymNJmSpreNWwbSw5jA8rsWnC2DsbxWmH7
 V5vAYg1xbRJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 08:34:08 -0700
IronPort-SDR: eV5C3H+cnoC0A8uX4kOxBmXf/PSL+93BTzOl8w2BmzU4Y5t+/ija7Mo2k1ocUFqS2o5A3HnkRd
 YpxgeX4S3jxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="465617760"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga005.fm.intel.com with ESMTP; 18 May 2020 08:34:08 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D3CA8301B7F; Mon, 18 May 2020 08:34:07 -0700 (PDT)
Date:   Mon, 18 May 2020 08:34:07 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200518153407.GA499505@tassilo.jf.intel.com>
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, for SGX this is functional feature because enclave entry points,
> thread control structures (aka TCS's), reset FSBASE and GSBASE registers
> to fixed (albeit user defined) values. And syscall's can be done only
> outside of enclave.
> 
> This is a required feature for fancier runtimes (such as Graphene).

Can you please explain a bit more? What do they need GS for?

-Andi
