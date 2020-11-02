Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516082A2402
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 06:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgKBFQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 00:16:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:14459 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgKBFQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 00:16:39 -0500
IronPort-SDR: E2xUTfWLURgs0WFgIBtbx0xzpfskzEq35PzyYxS51TQTv482ZkkYOSAyzAOC2CgivyIl0yx93Q
 S+EzJyRNJlIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="233006840"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="233006840"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 21:16:37 -0800
IronPort-SDR: XzWicV8W5OHWA6y4Ul1MAjvWe7qtSvwBANqirOSCjY1AS7L35rxKNxiyekaPN91/clwKg7GLco
 Vt1xo2rzQC+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="357220454"
Received: from lkp-server02.sh.intel.com (HELO 5575c2e0dde6) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2020 21:16:35 -0800
Received: from kbuild by 5575c2e0dde6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZSCo-00008I-Uj; Mon, 02 Nov 2020 05:16:34 +0000
Date:   Mon, 2 Nov 2020 13:15:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Divya Bharathi <divya.bharathi@dell.com>
Cc:     kbuild-all@lists.01.org, Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-platform-drivers-x86] platform/x86: po_is_pass_set
 can be static
Message-ID: <20201102051536.GA97836@d07872ef61d7>
References: <202011021321.WZVoG5Tr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202011021321.WZVoG5Tr-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Signed-off-by: kernel test robot <lkp@intel.com>
---
 passobj-attributes.c |   14 +++++++-------
 sysman.c             |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
index e6199fb748a95a..81562b178c9cdd 100644
--- a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
@@ -35,7 +35,7 @@ static ssize_t is_enabled_show(struct kobject *kobj, struct kobj_attribute *attr
 	return ret;
 }
 
-struct kobj_attribute po_is_pass_set =
+static struct kobj_attribute po_is_pass_set =
 		__ATTR_RO(is_enabled);
 
 static ssize_t current_password_store(struct kobject *kobj,
@@ -67,7 +67,7 @@ static ssize_t current_password_store(struct kobject *kobj,
 	return count;
 }
 
-struct kobj_attribute po_current_password =
+static struct kobj_attribute po_current_password =
 		__ATTR_WO(current_password);
 
 static ssize_t new_password_store(struct kobject *kobj,
@@ -96,15 +96,15 @@ static ssize_t new_password_store(struct kobject *kobj,
 	return ret ? ret : count;
 }
 
-struct kobj_attribute po_new_password =
+static struct kobj_attribute po_new_password =
 		__ATTR_WO(new_password);
 
 attribute_n_property_show(min_password_length, po);
-struct kobj_attribute po_min_pass_length =
+static struct kobj_attribute po_min_pass_length =
 		__ATTR_RO(min_password_length);
 
 attribute_n_property_show(max_password_length, po);
-struct kobj_attribute po_max_pass_length =
+static struct kobj_attribute po_max_pass_length =
 		__ATTR_RO(max_password_length);
 
 static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -113,7 +113,7 @@ static ssize_t mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
 	return sprintf(buf, "password\n");
 }
 
-struct kobj_attribute po_mechanism =
+static struct kobj_attribute po_mechanism =
 	__ATTR_RO(mechanism);
 
 static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -126,7 +126,7 @@ static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
 	return -EIO;
 }
 
-struct kobj_attribute po_role =
+static struct kobj_attribute po_role =
 	__ATTR_RO(role);
 
 static struct attribute *po_attrs[] = {
diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
index 3842575a6c189f..c6862c3e9b491a 100644
--- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
@@ -255,7 +255,7 @@ static ssize_t wmi_sysman_attr_store(struct kobject *kobj, struct attribute *att
 	return ret;
 }
 
-const struct sysfs_ops wmi_sysman_kobj_sysfs_ops = {
+static const struct sysfs_ops wmi_sysman_kobj_sysfs_ops = {
 	.show	= wmi_sysman_attr_show,
 	.store	= wmi_sysman_attr_store,
 };
