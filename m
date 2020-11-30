Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7412C903A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgK3Vr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgK3Vr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:47:57 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83824C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:47:17 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z10so4395166ilu.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=uHRoGKduNYCTLt7Vm4EAKOpPL4O7JjlLpBK56fqQN0Q=;
        b=TLq0Uz0hvBOy5MVW4qn1la3qCiMJ0YiY2P2Ggtj5mq4PHCaEHStJ8H2aZcazb507Zk
         E7npXccwPvM13WNbUOAWKQp9ovKoxYdjlBpStSNleGUIo4JqB79xASY1p5sd+WxReynN
         W0FoWbk4ZkH2kpZrCHlN4vAEkUxary+iumVmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=uHRoGKduNYCTLt7Vm4EAKOpPL4O7JjlLpBK56fqQN0Q=;
        b=R4WcYs6M948EhsslxAtMo9n2NUqr5TIhq4iPhjFuEsmJUI4jSyiBev5Y+YgrHNU++i
         2EI4aieRAutLu6ES/9ls6imkPXY/DBLDb/PyLTReIvABt6BjceVDfdAotI55mPFWhSen
         eWUsLdimx31t/lcz/cL8J3HVWjSNRwCpk7UR/gr8iMAL2L0w5ESZ2qH+IQVAYXttVmRk
         QyUVO1GCKCX8H5R/nGT28ZeVpyQdi5tJ9gbjKpenAKXxS8X9KZKAcXXzzLVIU1FWb+jh
         H8U0zQ93xS2DaYuVhbkS3cfeh5r2CfQcJ46C3aTzo/vuMaD+8aBPHymUcpUuWNmy0OD5
         88ZQ==
X-Gm-Message-State: AOAM533jjd5d7GFiM8Ow0+XUnUiDk4qUQvOu6AW3quBsiTddT8HJmNP1
        6+EZjgE1Ftff9qVHfSD34lw7Kg==
X-Google-Smtp-Source: ABdhPJx8yd5rux/e9hDpT9d54zZ0nKJZa5TbSt6OG5JCokrW8T7dUYmL+ORuGC6Gqb57ZeSKgN1WZw==
X-Received: by 2002:a92:b008:: with SMTP id x8mr14468700ilh.297.1606772836854;
        Mon, 30 Nov 2020 13:47:16 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r4sm5175822iop.24.2020.11.30.13.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:47:16 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.11-rc1
Message-ID: <a3689b5f-2835-066c-dcb5-6103a0e09f89@linuxfoundation.org>
Date:   Mon, 30 Nov 2020 14:47:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2CC919BA1B70204064BE1A20"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2CC919BA1B70204064BE1A20
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.11-rc1.

This cpupower update for Linux 5.11-rc1 consists of a change to provide
online and offline CPU information. This change makes it easier to keep
track of offline cpus whose cpuidle or cpufreq property aren't changed
when updates are made to online cpus.

Please note that there is a conflict in

tools/power/cpupower/utils/helpers/misc.c

between commit:

   748f0d70087c ("cpupower: Provide online and offline CPU information")

from the cpupower tree and commit:

   8113ab20e850 ("tools/power/cpupower: Read energy_perf_bias from sysfs")

from the tip tree.

Stephen fixed it up and can carry the fix. Hope this works.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux 
tags/linux-cpupower-5.11-rc1

for you to fetch changes up to 748f0d70087c56226bf1df1f91a00b7ab4c8f883:

   cpupower: Provide online and offline CPU information (2020-10-26 
13:36:24 -0600)

----------------------------------------------------------------
linux-cpupower-5.11-rc1

This cpupower update for Linux 5.11-rc1 consists of a change to provide
online and offline CPU information. This change makes it easier to keep
track of offline cpus whose cpuidle or cpufreq property aren't changed
when updates are made to online cpus.

----------------------------------------------------------------
Brahadambal Srinivasan (1):
       cpupower: Provide online and offline CPU information

  tools/power/cpupower/utils/cpufreq-set.c     |  3 ++
  tools/power/cpupower/utils/cpuidle-set.c     |  4 ++
  tools/power/cpupower/utils/cpupower.c        |  8 ++++
  tools/power/cpupower/utils/helpers/helpers.h | 12 +++++
  tools/power/cpupower/utils/helpers/misc.c    | 66 
+++++++++++++++++++++++++++-
  5 files changed, 92 insertions(+), 1 deletion(-)
----------------------------------------------------------------

--------------2CC919BA1B70204064BE1A20
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.11-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.11-rc1.diff"

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 7b2164e07057..c5e60a39cfa6 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -315,6 +315,7 @@ int cmd_freq_set(int argc, char **argv)
 		}
 	}
 
+	get_cpustate();
 
 	/* loop over CPUs */
 	for (cpu = bitmask_first(cpus_chosen);
@@ -332,5 +333,7 @@ int cmd_freq_set(int argc, char **argv)
 		}
 	}
 
+	print_offline_cpus();
+
 	return 0;
 }
diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index 569f268f4c7f..46158928f9ad 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -95,6 +95,8 @@ int cmd_idle_set(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	get_cpustate();
+
 	/* Default is: set all CPUs */
 	if (bitmask_isallclear(cpus_chosen))
 		bitmask_setall(cpus_chosen);
@@ -181,5 +183,7 @@ int cmd_idle_set(int argc, char **argv)
 			break;
 		}
 	}
+
+	print_offline_cpus();
 	return EXIT_SUCCESS;
 }
diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 8e3d08042825..8ac3304a9957 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -34,6 +34,8 @@ int run_as_root;
 int base_cpu;
 /* Affected cpus chosen by -c/--cpu param */
 struct bitmask *cpus_chosen;
+struct bitmask *online_cpus;
+struct bitmask *offline_cpus;
 
 #ifdef DEBUG
 int be_verbose;
@@ -178,6 +180,8 @@ int main(int argc, const char *argv[])
 	char pathname[32];
 
 	cpus_chosen = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
+	online_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
+	offline_cpus = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
 
 	argc--;
 	argv += 1;
@@ -230,6 +234,10 @@ int main(int argc, const char *argv[])
 		ret = p->main(argc, argv);
 		if (cpus_chosen)
 			bitmask_free(cpus_chosen);
+		if (online_cpus)
+			bitmask_free(online_cpus);
+		if (offline_cpus)
+			bitmask_free(offline_cpus);
 		return ret;
 	}
 	print_help();
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index c258eeccd05f..d5799aa71e1f 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -94,6 +94,8 @@ struct cpupower_cpu_info {
  */
 extern int get_cpu_info(struct cpupower_cpu_info *cpu_info);
 extern struct cpupower_cpu_info cpupower_cpu_info;
+
+
 /* cpuid and cpuinfo helpers  **************************/
 
 /* X86 ONLY ****************************************/
@@ -171,4 +173,14 @@ static inline unsigned int cpuid_ecx(unsigned int op) { return 0; };
 static inline unsigned int cpuid_edx(unsigned int op) { return 0; };
 #endif /* defined(__i386__) || defined(__x86_64__) */
 
+/*
+ * CPU State related functions
+ */
+extern struct bitmask *online_cpus;
+extern struct bitmask *offline_cpus;
+
+void get_cpustate(void);
+void print_online_cpus(void);
+void print_offline_cpus(void);
+
 #endif /* __CPUPOWERUTILS_HELPERS__ */
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index f406adc40bad..2ead98169cf5 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#if defined(__i386__) || defined(__x86_64__)
+
+#include <stdio.h>
+#include <stdlib.h>
 
 #include "helpers/helpers.h"
 
+#if defined(__i386__) || defined(__x86_64__)
+
 #define MSR_AMD_HWCR	0xc0010015
 
 int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
@@ -41,3 +45,63 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 	return 0;
 }
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
+
+/* get_cpustate
+ *
+ * Gather the information of all online CPUs into bitmask struct
+ */
+void get_cpustate(void)
+{
+	unsigned int cpu = 0;
+
+	bitmask_clearall(online_cpus);
+	bitmask_clearall(offline_cpus);
+
+	for (cpu = bitmask_first(cpus_chosen);
+		cpu <= bitmask_last(cpus_chosen); cpu++) {
+
+		if (cpupower_is_cpu_online(cpu) == 1)
+			bitmask_setbit(online_cpus, cpu);
+		else
+			bitmask_setbit(offline_cpus, cpu);
+
+		continue;
+	}
+}
+
+/* print_online_cpus
+ *
+ * Print the CPU numbers of all CPUs that are online currently
+ */
+void print_online_cpus(void)
+{
+	int str_len = 0;
+	char *online_cpus_str = NULL;
+
+	str_len = online_cpus->size * 5;
+	online_cpus_str = (void *)malloc(sizeof(char) * str_len);
+
+	if (!bitmask_isallclear(online_cpus)) {
+		bitmask_displaylist(online_cpus_str, str_len, online_cpus);
+		printf(_("Following CPUs are online:\n%s\n"), online_cpus_str);
+	}
+}
+
+/* print_offline_cpus
+ *
+ * Print the CPU numbers of all CPUs that are offline currently
+ */
+void print_offline_cpus(void)
+{
+	int str_len = 0;
+	char *offline_cpus_str = NULL;
+
+	str_len = offline_cpus->size * 5;
+	offline_cpus_str = (void *)malloc(sizeof(char) * str_len);
+
+	if (!bitmask_isallclear(offline_cpus)) {
+		bitmask_displaylist(offline_cpus_str, str_len, offline_cpus);
+		printf(_("Following CPUs are offline:\n%s\n"), offline_cpus_str);
+		printf(_("cpupower set operation was not performed on them\n"));
+	}
+}

--------------2CC919BA1B70204064BE1A20--
