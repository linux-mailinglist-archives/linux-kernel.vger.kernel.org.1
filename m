Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1992B8872
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKRXfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:35:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:30576 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgKRXfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:35:31 -0500
IronPort-SDR: JwQG1NpOAGuIXilfbCB4QMPvsJR8FUjHd4PEdadEEqD0KeOqYnm4jGhUce4V8kpnlGua4St52O
 ixiKG8sK8hNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158975411"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="158975411"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 15:35:31 -0800
IronPort-SDR: OkdchkXaujI5vp5VYuLXIaNe4jnHt5rKnVixn9wQnIUiwpZC8uQfMhsw5rjTVRrTSNSkVusLqz
 XYqQZYUJYS5A==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="534527725"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.255.230.225]) ([10.255.230.225])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 15:35:30 -0800
Subject: Re: [PATCH] x86/resctrl: Constify kernfs_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20201110230228.801785-1-rikard.falkeborn@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3a32fd8a-2b41-3be5-2742-540ada4a21e5@intel.com>
Date:   Wed, 18 Nov 2020 15:35:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201110230228.801785-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2020 3:02 PM, Rikard Falkeborn wrote:
> The only usage of the kf_ops field in the rftype struct is to pass it as
> argument to __kernfs_create_file(), which accepts a pointer to const.
> Make it a pointer to const. This makes it possible to make
> rdtgroup_kf_single_ops and kf_mondata_ops const, which allows the
> compiler to put them in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Thank you very much Rikard.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
