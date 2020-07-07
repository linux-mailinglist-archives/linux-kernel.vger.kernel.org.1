Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F82A216BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGGLlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 07:41:47 -0400
Received: from mailomta32-re.btinternet.com ([213.120.69.125]:22355 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbgGGLlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:41:46 -0400
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200707114143.YIZZ4657.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Tue, 7 Jul 2020 12:41:43 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=j.oldman998@btinternet.com
X-Originating-IP: [31.53.71.41]
X-OWM-Source-IP: 31.53.71.41 (GB)
X-OWM-Env-Sender: j.oldman998@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomheplfhohhhnucfqlhgumhgrnhcuoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqnecuggftrfgrthhtvghrnhepgeeftdfhfeeuiefhgfekfeethedutddtfeduteevleevfedvfefhjeeijefhgffgnecukfhppeefuddrheefrdejuddrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohephhgvnhhrhidrhhhomhgvpdhinhgvthepfedurdehfedrjedurdeguddpmhgrihhlfhhrohhmpeeojhhohhhnrdholhgumhgrnhesphholhgvhhhilhhlrdgtohdruhhkqedprhgtphhtthhopeeovghvvghlsegurhhivhgvrhguvghvrdhoshhuohhslhdrohhrgheqpdhrtghpthhtohepoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqpdhrtghpthhtohepoehjohhhnhdrohhlughmrghnsehpohhlvghhihhllhdrtghordhukheqpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from henry.home (31.53.71.41) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as j.oldman998@btinternet.com)
        id 5ED9C0CC05A79E9B; Tue, 7 Jul 2020 12:41:42 +0100
From:   John Oldman <john.oldman@polehill.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     evel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Oldman <john.oldman@polehill.co.uk>
Subject: [PATCH] staging: rtl8723bs: Using comparison to true is error prone
Date:   Tue,  7 Jul 2020 12:41:28 +0100
Message-Id: <20200707114128.30312-1-john.oldman@polehill.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear below issues reported by checkpatch.pl:

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error pron

Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 70 ++++++++++-----------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 50a3c2c3a8d2..27f990a01a23 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -313,7 +313,7 @@ static int rtw_net_set_mac_address(struct net_device *pnetdev, void *p)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct sockaddr *addr = p;

-	if (padapter->bup == false) {
+	if (!padapter->bup) {
 		/* DBG_871X("r8711_net_set_mac_address(), MAC =%x:%x:%x:%x:%x:%x\n", addr->sa_data[0], addr->sa_data[1], addr->sa_data[2], addr->sa_data[3], */
 		/* addr->sa_data[4], addr->sa_data[5]); */
 		memcpy(padapter->eeprompriv.mac_addr, addr->sa_data, ETH_ALEN);
@@ -897,12 +897,12 @@ int _netdev_open(struct net_device *pnetdev)

 	padapter->netif_up = true;

-	if (pwrctrlpriv->ps_flag == true) {
+	if (pwrctrlpriv->ps_flag) {
 		padapter->net_closed = false;
 		goto netdev_open_normal_process;
 	}

-	if (padapter->bup == false) {
+	if (!padapter->bup) {
 		padapter->bDriverStopped = false;
 		padapter->bSurpriseRemoved = false;
 		padapter->bCardDisableWOHSM = false;
@@ -964,7 +964,7 @@ int netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);

-	if (pwrctrlpriv->bInSuspend == true) {
+	if (pwrctrlpriv->bInSuspend) {
 		DBG_871X("+871x_drv - drv_open, bInSuspend =%d\n", pwrctrlpriv->bInSuspend);
 		return 0;
 	}
@@ -1041,7 +1041,7 @@ void rtw_ips_dev_unload(struct adapter *padapter)
 	DBG_871X("====> %s...\n", __func__);


-	if (padapter->bSurpriseRemoved == false)
+	if (!padapter->bSurpriseRemoved)
 		rtw_hal_deinit(padapter);
 }

@@ -1052,7 +1052,7 @@ static int pm_netdev_open(struct net_device *pnetdev, u8 bnormal)

 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);

-	if (true == bnormal) {
+	if (bnormal) {
 		if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->hw_init_mutex)) == 0) {
 			status = _netdev_open(pnetdev);
 			mutex_unlock(&(adapter_to_dvobj(padapter)->hw_init_mutex));
@@ -1071,7 +1071,7 @@ static int netdev_close(struct net_device *pnetdev)

 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+871x_drv - drv_close\n"));

-	if (pwrctl->bInternalAutoSuspend == true) {
+	if (pwrctl->bInternalAutoSuspend) {
 		/* rtw_pwr_wakeup(padapter); */
 		if (pwrctl->rf_pwrstate == rf_off)
 			pwrctl->ps_flag = true;
@@ -1134,7 +1134,7 @@ void rtw_dev_unload(struct adapter *padapter)

 	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+%s\n", __func__));

-	if (padapter->bup == true) {
+	if (padapter->bup) {
 		DBG_871X("===> %s\n", __func__);

 		padapter->bDriverStopped = true;
@@ -1149,7 +1149,7 @@ void rtw_dev_unload(struct adapter *padapter)
 		if (!pwrctl->bInternalAutoSuspend)
 			rtw_stop_drv_threads(padapter);

-		while (atomic_read(&(pcmdpriv->cmdthd_running)) == true) {
+		while (atomic_read(&pcmdpriv->cmdthd_running)) {
 			if (cnt > 5) {
 				DBG_871X("stop cmdthd timeout\n");
 				break;
@@ -1163,7 +1163,8 @@ void rtw_dev_unload(struct adapter *padapter)
 		RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("@ %s: stop thread complete!\n", __func__));

 		/* check the status of IPS */
-		if (rtw_hal_check_ips_status(padapter) == true || pwrctl->rf_pwrstate == rf_off) { /* check HW status and SW state */
+		if (rtw_hal_check_ips_status(padapter) || pwrctl->rf_pwrstate == rf_off) {
+			/* check HW status and SW state */
 			DBG_871X_LEVEL(_drv_always_, "%s: driver in IPS-FWLPS\n", __func__);
 			pdbgpriv->dbg_dev_unload_inIPS_cnt++;
 			LeaveAllPowerSaveMode(padapter);
@@ -1171,11 +1172,10 @@ void rtw_dev_unload(struct adapter *padapter)
 			DBG_871X_LEVEL(_drv_always_, "%s: driver not in IPS\n", __func__);
 		}

-		if (padapter->bSurpriseRemoved == false) {
+		if (!padapter->bSurpriseRemoved) {
 			hal_btcoex_IpsNotify(padapter, pwrctl->ips_mode_req);
 #ifdef CONFIG_WOWLAN
-			if (pwrctl->bSupportRemoteWakeup == true &&
-				pwrctl->wowlan_mode == true) {
+			if (pwrctl->bSupportRemoteWakeup && pwrctl->wowlan_mode) {
 				DBG_871X_LEVEL(_drv_always_, "%s bSupportRemoteWakeup ==true  do not run rtw_hal_deinit()\n", __func__);
 			}
 			else
@@ -1235,7 +1235,7 @@ static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		rtw_indicate_scan_done(padapter, 1);

-	if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 		DBG_871X_LEVEL(_drv_always_, "%s: fw_under_linking\n", __func__);
 		rtw_indicate_disconnect(padapter);
 	}
@@ -1259,7 +1259,7 @@ void rtw_suspend_wow(struct adapter *padapter)
 	DBG_871X("wowlan_mode: %d\n", pwrpriv->wowlan_mode);
 	DBG_871X("wowlan_pno_enable: %d\n", pwrpriv->wowlan_pno_enable);

-	if (pwrpriv->wowlan_mode == true) {
+	if (pwrpriv->wowlan_mode) {
 		if (pnetdev)
 			rtw_netif_stop_queue(pnetdev);
 		/*  1. stop thread */
@@ -1283,8 +1283,7 @@ void rtw_suspend_wow(struct adapter *padapter)
 		poidparam.subcode = WOWLAN_ENABLE;
 		padapter->HalFunc.SetHwRegHandler(padapter, HW_VAR_WOWLAN, (u8 *)&poidparam);
 		if (rtw_chk_roam_flags(padapter, RTW_ROAM_ON_RESUME)) {
-			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
-				&& check_fwstate(pmlmepriv, _FW_LINKED)) {
+			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) && check_fwstate(pmlmepriv, _FW_LINKED)) {
 				DBG_871X("%s %s(" MAC_FMT "), length:%d assoc_ssid.length:%d\n", __func__,
 						pmlmepriv->cur_network.network.Ssid.Ssid,
 						MAC_ARG(pmlmepriv->cur_network.network.MacAddress),
@@ -1297,7 +1296,7 @@ void rtw_suspend_wow(struct adapter *padapter)

 		DBG_871X_LEVEL(_drv_always_, "%s: wowmode suspending\n", __func__);

-		if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true) {
+		if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 			DBG_871X_LEVEL(_drv_always_, "%s: fw_under_survey\n", __func__);
 			rtw_indicate_scan_done(padapter, 1);
 			clr_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
@@ -1313,8 +1312,7 @@ void rtw_suspend_wow(struct adapter *padapter)
 			DBG_871X_LEVEL(_drv_always_, "%s: pno: %d\n", __func__, pwrpriv->wowlan_pno_enable);
 		else
 			rtw_set_ps_mode(padapter, PS_MODE_DTIM, 0, 0, "WOWLAN");
-	}
-	else {
+	} else {
 		DBG_871X_LEVEL(_drv_always_, "%s: ### ERROR ### wowlan_mode =%d\n", __func__, pwrpriv->wowlan_mode);
 	}
 	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
@@ -1385,10 +1383,8 @@ static void rtw_suspend_normal(struct adapter *padapter)

 	rtw_suspend_free_assoc_resource(padapter);

-	if ((rtw_hal_check_ips_status(padapter) == true)
-		|| (adapter_to_pwrctl(padapter)->rf_pwrstate == rf_off)) {
+	if ((rtw_hal_check_ips_status(padapter)) || (adapter_to_pwrctl(padapter)->rf_pwrstate == rf_off))
 		DBG_871X_LEVEL(_drv_always_, "%s: ### ERROR #### driver in IPS ####ERROR###!!!\n", __func__);
-	}

 	rtw_dev_unload(padapter);

@@ -1415,7 +1411,7 @@ int rtw_suspend_common(struct adapter *padapter)

 	pwrpriv->bInSuspend = true;

-	while (pwrpriv->bips_processing == true)
+	while (pwrpriv->bips_processing)
 		msleep(1);

 	if ((!padapter->bup) || (padapter->bDriverStopped) || (padapter->bSurpriseRemoved)) {
@@ -1433,24 +1429,24 @@ int rtw_suspend_common(struct adapter *padapter)
 	rtw_stop_cmd_thread(padapter);

 	/*  wait for the latest FW to remove this condition. */
-	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		hal_btcoex_SuspendNotify(padapter, 0);
 		DBG_871X("WIFI_AP_STATE\n");
-	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		hal_btcoex_SuspendNotify(padapter, 1);
 		DBG_871X("STATION\n");
 	}

 	rtw_ps_deny_cancel(padapter, PS_DENY_SUSPEND);

-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 	#ifdef CONFIG_WOWLAN
 		if (check_fwstate(pmlmepriv, _FW_LINKED))
 			pwrpriv->wowlan_mode = true;
-		else if (pwrpriv->wowlan_pno_enable == true)
+		else if (pwrpriv->wowlan_pno_enable)
 			pwrpriv->wowlan_mode |= pwrpriv->wowlan_pno_enable;

-		if (pwrpriv->wowlan_mode == true)
+		if (pwrpriv->wowlan_mode)
 			rtw_suspend_wow(padapter);
 		else
 			rtw_suspend_normal(padapter);
@@ -1458,7 +1454,7 @@ int rtw_suspend_common(struct adapter *padapter)
 	#else /* CONFIG_WOWLAN */
 		rtw_suspend_normal(padapter);
 	#endif /* CONFIG_WOWLAN */
-	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 	#ifdef CONFIG_AP_WOWLAN
 		rtw_suspend_ap_wow(padapter);
 	#else
@@ -1513,7 +1509,7 @@ int rtw_resume_process_wow(struct adapter *padapter)
 	pwrpriv->pno_in_resume = true;
 #endif

-	if (pwrpriv->wowlan_mode == true) {
+	if (pwrpriv->wowlan_mode) {
 		rtw_set_ps_mode(padapter, PS_MODE_ACTIVE, 0, 0, "WOWLAN");

 		pwrpriv->bFwCurrentInPSMode = false;
@@ -1553,8 +1549,7 @@ int rtw_resume_process_wow(struct adapter *padapter)
 			else
 				rtw_netif_wake_queue(pnetdev);
 		}
-	}
-	else {
+	} else {
 		DBG_871X_LEVEL(_drv_always_, "%s: ### ERROR ### wowlan_mode =%d\n", __func__, pwrpriv->wowlan_mode);
 	}

@@ -1584,7 +1579,7 @@ int rtw_resume_process_wow(struct adapter *padapter)
 		}
 	}

-	if (pwrpriv->wowlan_mode == true) {
+	if (pwrpriv->wowlan_mode) {
 		pwrpriv->bips_processing = false;
 		_set_timer(&padapter->mlmepriv.dynamic_chk_timer, 2000);
 	} else {
@@ -1730,7 +1725,6 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 		rtw_signal_process(padapter->pid[1], SIGUSR2);
 	}

-
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		DBG_871X(FUNC_ADPT_FMT " fwstate:0x%08x - WIFI_STATION_STATE\n", FUNC_ADPT_ARG(padapter), get_fwstate(pmlmepriv));

@@ -1762,9 +1756,9 @@ int rtw_resume_common(struct adapter *padapter)
 	DBG_871X_LEVEL(_drv_always_, "resume start\n");
 	DBG_871X("==> %s (%s:%d)\n", __func__, current->comm, current->pid);

-	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 	#ifdef CONFIG_WOWLAN
-		if (pwrpriv->wowlan_mode == true)
+		if (pwrpriv->wowlan_mode)
 			rtw_resume_process_wow(padapter);
 		else
 			rtw_resume_process_normal(padapter);
@@ -1772,7 +1766,7 @@ int rtw_resume_common(struct adapter *padapter)
 		rtw_resume_process_normal(padapter);
 	#endif

-	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 	#ifdef CONFIG_AP_WOWLAN
 		rtw_resume_process_ap_wow(padapter);
 	#else
--
2.17.1

