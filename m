Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD712A466C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgKCN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:29:27 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:63763 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgKCN3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:29:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604410164; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=EVEYr3r+1nK4mjqeUe+SKQHlRPiCZaaEh9hkp+cin7U=; b=XfPUOUb8oEreLqQhHuEFz6HdQbmp0CqPyTBG6fEcvihcNdq/FXPYymWBhyoVGyTVhfYTOirQ
 ruazeI+bxCGQsoSyHBDCRBix9WPzKQUZ8N8K3rjuYUAF8No3yNwXe6yeHtWjmoCEPqXKcB6E
 gb224mkzxQ9lrSiH/Zct/Lmmoco=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fa15af81037425ce1164510 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 13:28:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0F04C38553; Tue,  3 Nov 2020 10:09:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C130C38538;
        Tue,  3 Nov 2020 10:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C130C38538
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Tamizh Chelvam <tamizhr@codeaurora.org>,
        lkp@intel.com, Dan Carpenter <error27@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: drivers/net/wireless/ath/ath10k/mac.c:9125 ath10k_mac_op_set_tid_config() error: uninitialized symbol 'ret'.
References: <20201103100037.GE12347@kadam>
Date:   Tue, 03 Nov 2020 12:09:35 +0200
In-Reply-To: <20201103100037.GE12347@kadam> (Dan Carpenter's message of "Tue,
        3 Nov 2020 13:00:37 +0300")
Message-ID: <874km6u4yo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath10k list

Dan Carpenter <dan.carpenter@oracle.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3cea11cd5e3b00d91caf0b4730194039b45c5891
> commit: 7b2531d93bac6bea67e9c7f49901e9e8796d6d57 ath10k: Add new api to support TID specific configuration
> config: x86_64-randconfig-m031-20201102 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/net/wireless/ath/ath10k/mac.c:9125 ath10k_mac_op_set_tid_config() error: uninitialized symbol 'ret'.
>
> vim +/ret +9125 drivers/net/wireless/ath/ath10k/mac.c
>
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9089  static int ath10k_mac_op_set_tid_config(struct ieee80211_hw *hw,
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9090  					struct ieee80211_vif *vif,
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9091  					struct ieee80211_sta *sta,
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9092  					struct cfg80211_tid_config *tid_config)
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9093  {
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9094  	struct ath10k *ar = hw->priv;
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9095  	struct ath10k_vif *arvif = (void *)vif->drv_priv;
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9096  	struct ath10k_mac_iter_tid_conf_data data = {};
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9097  	struct wmi_per_peer_per_tid_cfg_arg arg = {};
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9098  	int ret, i;
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9099  
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9100  	mutex_lock(&ar->conf_mutex);
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9101  	arg.vdev_id = arvif->vdev_id;
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9102  
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9103  	memset(arvif->tid_conf_changed, 0, sizeof(arvif->tid_conf_changed));
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9104  
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9105  	for (i = 0; i < tid_config->n_tid_conf; i++) {
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9106  		ret = ath10k_mac_parse_tid_config(ar, sta, vif,
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9107  						  &tid_config->tid_conf[i],
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9108  						  &arg);
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9109  		if (ret)
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9110  			goto exit;
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9111  	}
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9112  
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9113  	if (sta)
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9114  		goto exit;
>                                                                 ^^^^^^^^^^
>
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9115  
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9116  	ret = 0;
>                                                         ^^^^^^^^
> Probably just move this to the "int ret = 0;" start of the function?

Or preferably before "if (sta)" check. Tamizh, please send a fix.

> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9117  	data.curr_vif = vif;
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9118  	data.ar = ar;
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9119  
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9120  	ieee80211_iterate_stations_atomic(hw, ath10k_mac_vif_stations_tid_conf,
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9121  					  &data);
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9122  
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9123  exit:
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9124  	mutex_unlock(&ar->conf_mutex);
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19 @9125  	return ret;
> 7b2531d93bac6be Tamizh Chelvam  2020-08-19  9126  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
