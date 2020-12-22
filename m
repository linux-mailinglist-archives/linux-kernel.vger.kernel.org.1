Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8582E08AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 11:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgLVKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 05:17:43 -0500
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:58084
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgLVKRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 05:17:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YleAoCGH7h5j6sZAKNbZh6pzUM7uszRJ8EzP1pZWHYa8TWMo491oiVmU8eIJpfWaGVOr/O6ADwvvrwJ9M3N/poVb49Pe4vIeOwWQTawslvcTBR0TqLOryzhOMQd9T4Jio/AwbevJSvQyv88cQHvzSv8mHxaQMsIaR2bgDuD1hF0+ytZuNRC3xamrYb0xmN3XzXJanXnfeq9+V+XZ8ZEUv4X6BJxIXxHnIg28bKpgi7eF0wLqf5Nwn7GuERckNNyhdQ0KhLAFke2l3Am3JpzPlEha2Ef7LkH0+TaJKrEl/XOFdcN+DQviBDdKYwLljcjr2Qtoxfr5kgw8/XPt7mNkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKSf90qsvUKGuvUS4iy96EPDapfBIK/+latvAJh9GXA=;
 b=nYbxQBY/sAH+Fw9JJXaTQbc+//PYn1ee9ObzEyzAtwhamxtDmW8mZgh8kHSryG9QiF/gY9PEEEeyd7dJ5XwvhcoBfqVRl3UaJvy2gmO/CHwR7XMuKh6ZR6DQdDYAks3HcPrAkC7EkTFZkrqoAt8x1vwdH/vzpNUokkQc/+ZDxc80mJKvqvH1iQAb6olLY0b90J7Ybxi4XlZeV6hhd/yG6EDVMeUDfAtPnvfrErXZBPeoklBjzpkrddfKIjoMn1YsY/oYQisvZjVYv5Zw7pMGars85xYDMO2q5F1+vR/oAG7YoOoa8ekM95MhLptNxwrFU+aWhVPP9uuxUqEzmRtRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKSf90qsvUKGuvUS4iy96EPDapfBIK/+latvAJh9GXA=;
 b=zAmyFmNw4y+d9oaSebD/DSLcihjA/qCP81xhMELXVX1daCAT4/WTAKGYJhRsDsn2rrnLZmAl+fh80pmC0gizO6FKgyOUtXFdigEX54LYkirgXPHlGRre0J934w07/+b6zHmNk3zsoENoBi3niUwcEiSmkGp2pDoLPKbDzV9np9H7y6/vxaDKzjTKWzaFKCnPsBBcgazxYBVaLrE5DTE5/sjJXdfguirQ/MDURFilUFP3pt2zSYqFff7Y09dxetX2fzAugV7tTODjbtz7J2sJLf5vTo/QCROO5FvyPbnsf2hb2evzxDIsOvTxJPg1//Wlim+XSsAp73iqAiEGFDa2xw==
Authentication-Results: omprussia.ru; dkim=none (message not signed)
 header.d=none;omprussia.ru; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0601MB2251.eurprd06.prod.outlook.com (2603:10a6:3:98::19)
 by HE1PR0602MB2939.eurprd06.prod.outlook.com (2603:10a6:3:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Tue, 22 Dec
 2020 10:16:55 +0000
Received: from HE1PR0601MB2251.eurprd06.prod.outlook.com
 ([fe80::d94d:101b:888d:e50d]) by HE1PR0601MB2251.eurprd06.prod.outlook.com
 ([fe80::d94d:101b:888d:e50d%12]) with mapi id 15.20.3676.033; Tue, 22 Dec
 2020 10:16:55 +0000
Subject: Re: [PATCH v4] tee: add support for application-based session login
 methods
To:     Elvira Khabirova <e.khabirova@omprussia.ru>,
        op-tee@lists.trustedfirmware.org
Cc:     linux-kernel@vger.kernel.org, k.karasev@omprussia.ru,
        s.shtylyov@omprussia.ru, jens.wiklander@linaro.org,
        i.zhbanov@omprussia.ru
References: <20201017200218.5d532d73@akathisia>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
Message-ID: <253db25d-2d87-d125-92c2-2f9979167023@vaisala.com>
Date:   Tue, 22 Dec 2020 12:16:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201017200218.5d532d73@akathisia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.86.154.78]
X-ClientProxiedBy: HE1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::45) To HE1PR0601MB2251.eurprd06.prod.outlook.com
 (2603:10a6:3:98::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.20] (88.86.154.78) by HE1PR0102CA0068.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29 via Frontend Transport; Tue, 22 Dec 2020 10:16:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35513072-3500-49be-2085-08d8a662b568
X-MS-TrafficTypeDiagnostic: HE1PR0602MB2939:
X-Microsoft-Antispam-PRVS: <HE1PR0602MB29397E86B461114D99E56C3BEDDF0@HE1PR0602MB2939.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aqZnHRnmFpmgftgk8UrP7hlV55c3DJ2aGRreI5xQhbzvjU1chU+tnLjN+pd3RjwLOpCYueJPOm1oInZR30risdSdNsAHS+DpWV71dMxddPHlre0htduq1aR34JIQv8R5EsUp7M7nkf9/sVNRBEZIaM4D97lMEwkBfn4rfi0w4/jAnIqxrmeBmphvHzgf/SfSmsFM4iXm+mbbbr/s6YfxLlKlbY1VsJG/AcRq4hMuXY1T+x8fWir//YA4NYSNUj2MC8xECJHuQuWL++8m1i0mhWFhWTQ+2X5qlA4raHEHhJch6ewypTvblAQ0aBf+g1hJK+GhmY3ATDtQeHYriGBrqy4zBnRdQZTL5CTG0OcFBNr2I/bkkusNbIzSgqvJZdUowdPBFtKrl3VaZdV/RT45tHedSglPbsTl3UyLCcJTxaYv/CT3M1lslc0RSvqq/xbg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0601MB2251.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(2616005)(83380400001)(2906002)(478600001)(956004)(8936002)(31686004)(4001150100001)(85202003)(16526019)(186003)(66946007)(5660300002)(31696002)(66476007)(66574015)(86362001)(85182001)(16576012)(53546011)(316002)(36756003)(6486002)(4326008)(8676002)(52116002)(26005)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V01lUnJQbzlCUGpXNFRIYW1tcXNvRG1acDNqWFVHNUFTY0Y5ZUx0MHpIc2xE?=
 =?utf-8?B?cjB2UUc3R09oVmZ0eGw4N0tRZmJMOWwrRkRtdDRxTFNVQitseURXQlRwMUdP?=
 =?utf-8?B?T2JpelJ4aFJsYTlyNWF6OHlnTkNlenhrWVFwdXVEck00UTRRMUNnQkphRmlZ?=
 =?utf-8?B?VUJNdFdVb08zQzVnaFBhaUt5bkFPWEVYcFBOemdwLzh1bDNMR1d0UmJlUFZE?=
 =?utf-8?B?c3JNcGg4WUJKWjd6a0U1V29zZ3Y5TVJIWlcxaG9XdytnUkl1S1lYTjBFcHF4?=
 =?utf-8?B?cm5yOWwvM0dlTEE2UlRsVldyRENITEt2bmZHbndVcFJqMC9SN245V1AzVnRX?=
 =?utf-8?B?N1pkZ0Q2UXFSTGUzRkwwMDA5TWNZR1M5UGdqbzNGdWFRRUdaVjdkaTVibU1t?=
 =?utf-8?B?RmpBZ29OV0ZnTGFTcHlwQkVEVHJ3M0RpVEJGY0J2eWFiU1RzUmlDYUEwUm84?=
 =?utf-8?B?dUptc0VBS290OStlRHp6R2RGM09mQmdVdWErekRMcFVDb1lqZkM4UTFTYVp0?=
 =?utf-8?B?ajQ3UVNTSUpWbmdNemQ3YUNPRE5HNElSUitQT3VBU1kyWE14b3JJeHZEUVJo?=
 =?utf-8?B?UkxYSWU1SjRKb1ZvbDRBdzlBalVzVWZNM1dWVEYzbXNVeHl5MHpIOVpoUUh1?=
 =?utf-8?B?ZUNuZEZwSlBLb0lReEc1cmRkbU85aTZjdFhWVnZCeFE1ekJHREd0RFBCQkM3?=
 =?utf-8?B?aHhjVG1HblFSVVpkcXN6cWR6NUsreUpWbENlSzVndDZFSS93M1JNRzhSZm50?=
 =?utf-8?B?RmJQVTJEZDczNEpnQUVHeGZRVVdEV1Z6MDlPTlM1Q1dFaVFBRmVLRXZwc0Ft?=
 =?utf-8?B?Ui9sUjFiYnQyMEtkeWl0SDhqbHRYamV3N0JZcE1McVZrWGlEZVlNMHZnVXBL?=
 =?utf-8?B?QTZIM0w4VnhrNjdnTmlXakdnN1ZiMko1RUM2KzBpUkxySGw1ZkwyNC91MnNu?=
 =?utf-8?B?TzlkY2JrYlNMZjkwWFdScU1ldEtTTkdhMFYwZkdPS2hKSnhZMzlUWjdmbWY2?=
 =?utf-8?B?L2IwTjI3ZEM5WkZjNDNuNkFxdVA0Qm0xR0tScWsxL2V0VXU2dE82dEhhYTJV?=
 =?utf-8?B?aDJsYjlvdEsvSnM4c0lXQnhJOW5mZ3YvQzNVY0tET1Z6WlExK2RpcTNoVlpj?=
 =?utf-8?B?MUUzTE1pUUlDdmRSWDVRZzE4WHlCTUhYVk5pSGtsVFpGY29YWHR4N1JnSDQr?=
 =?utf-8?B?eWdValNPbGFkeXFZbFB1Mm8rMWFPZVdybjB1MTBuWW44amtiREN4VENHb21K?=
 =?utf-8?B?RXpNYUQ5VUxUeGpsaTZIVUtrSy9ubTdTMU1tQjgvL055eDBjQ3Y5YkNSZHkv?=
 =?utf-8?Q?OBzZZZxDVdcxKHRXW+G6PvC4Jr1NEgUc/z?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0601MB2251.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 10:16:55.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-Network-Message-Id: 35513072-3500-49be-2085-08d8a662b568
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPlQLahuPAgOoQ9gUHtTXh3EpRgmW7WPHipOnSXGNSDeJG46gc7fpJ+GZzxtVrInizL5EHooT8f4ct56t1zEC4DlIKandir1j6YGZeqVkMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB2939
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elvira,

Sorry for not noticing this earlier.

And thanks for working on the application ID part.

On 2020-10-17 20:02, Elvira Khabirova wrote:
> GP TEE Client API in addition to login methods already supported
> in the kernel also defines several application-based methods:
> TEEC_LOGIN_APPLICATION, TEEC_LOGIN_USER_APPLICATION, and
> TEEC_LOGIN_GROUP_APPLICATION.
> 
> It specifies credentials generated for TEEC_LOGIN_APPLICATION as only
> depending on the identity of the program, being persistent within one
> implementation, across multiple invocations of the application
> and across power cycles, enabling them to be used to disambiguate
> persistent storage. The exact nature is REE-specific.
> 
> As the exact method of generating application identifier strings may
> vary between vendors, setups and installations, add two suggested
> methods and an exact framework for vendors to extend upon.
> 
> Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
> ---
> Changes in v4:
> - Fix potential exe_file leaks.
> 
> Changes in v3:
> - Remove free_app_id() and replace it with calls to kfree().
> 
> Changes in v2:
> - Rename some functions and variables to make them shorter.
> - Include linux/security.h unconditionally.
> - Restructure error handling in tee_session_calc_client_uuid().
> ---
>   drivers/tee/Kconfig    |  29 ++++++++++
>   drivers/tee/tee_core.c | 126 ++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 147 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> index e99d840c2511..4cd6e0d2aad5 100644
> --- a/drivers/tee/Kconfig
> +++ b/drivers/tee/Kconfig
> @@ -11,6 +11,35 @@ config TEE
>   	  This implements a generic interface towards a Trusted Execution
>   	  Environment (TEE).
>   
> +choice
> +	prompt "Application ID for client UUID"
> +	depends on TEE
> +	default TEE_APPID_PATH
> +	help
> +	  This option allows to choose which method will be used to generate
> +	  application identifiers for client UUID generation when login methods
> +	  TEE_LOGIN_APPLICATION, TEE_LOGIN_USER_APPLICATION
> +	  and TEE_LOGIN_GROUP_APPLICATION are used.
> +	  Please be mindful of the security of each method in your particular
> +	  installation.
> +
> +	config TEE_APPID_PATH
> +		bool "Path-based application ID"
> +		help
> +		  Use the executable's path as an application ID.
> +
> +	config TEE_APPID_SECURITY
> +		bool "Security extended attribute based application ID"
> +		help
> +		  Use the executable's security extended attribute as an application ID.
> +endchoice
> +
> +config TEE_APPID_SECURITY_XATTR
> +	string "Security extended attribute to use for application ID"
> +	depends on TEE_APPID_SECURITY
> +	help
> +	  Attribute to be used as an application ID (with the security prefix removed).
> +
>   if TEE
>   
>   menu "TEE drivers"
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 64637e09a095..a72b8c19253a 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -7,9 +7,12 @@
>   
>   #include <linux/cdev.h>
>   #include <linux/cred.h>
> +#include <linux/file.h>
>   #include <linux/fs.h>
>   #include <linux/idr.h>
> +#include <linux/mm.h>
>   #include <linux/module.h>
> +#include <linux/security.h>
>   #include <linux/slab.h>
>   #include <linux/tee_drv.h>
>   #include <linux/uaccess.h>
> @@ -21,7 +24,7 @@
>   
>   #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
>   
> -#define TEE_UUID_NS_NAME_SIZE	128
> +#define TEE_UUID_NS_NAME_SIZE	PATH_MAX

Just wondering should we get rid of this limit.

>   
>   /*
>    * TEE Client UUID name space identifier (UUIDv4)
> @@ -125,6 +128,65 @@ static int tee_release(struct inode *inode, struct file *filp)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_TEE_APPID_SECURITY
> +static const char *get_app_id(void **data)
> +{
> +	struct file *exe_file;
> +	const char *name = CONFIG_TEE_APPID_SECURITY_XATTR;
> +	int len;
> +
> +	exe_file = get_mm_exe_file(current->mm);
> +	if (!exe_file)
> +		return ERR_PTR(-ENOENT);
> +
> +	if (!exe_file->f_inode) {
> +		fput(exe_file);
> +		return ERR_PTR(-ENOENT);
> +	}
> +
> +	/*
> +	 * An identifier string for the binary. Depends on the implementation.
> +	 * Could be, for example, a string containing the application vendor ID,
> +	 * or the binary's signature, or its hash and a timestamp.
> +	 */
> +	len = security_inode_getsecurity(exe_file->f_inode, name, data, true);
> +	fput(exe_file);

This is all about binary being executed and might be good for many purposes.

Just wondering as we have security context in process should we be 
getting it from there instead? (struct cred::security)

Problem with that is that it is very security framework specific and 
then code in here would need to be aware what security framework is 
plugged in and so on -- so it can get complex.

There are some application launchers that setup security context and 
then that is persisted for child processes. How that works in upstream 
kernel today I cannot say.

If we rename CONFIG_TEE_APPID_SECURITY to more specific what happens 
here then one could extend it later for those inherited credential cases 
-- so perhaps rename as CONFIG_TEE_APPID_FS_XATTR_SECURITY or so?

> +
> +	if (len < 0)
> +		return ERR_PTR(len);
> +
> +	return *data;
> +}
> +#endif /* CONFIG_TEE_APPID_SECURITY */
> +
> +#ifdef CONFIG_TEE_APPID_PATH
> +static const char *get_app_id(void **data)
> +{
> +	struct file *exe_file;
> +	char *path;
> +
> +	*data = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);

If we change this to PATH_MAX then we don't need to worry that in here. 
This is anyway allocating the memory and then would follow the right 
thing in here whatever the value of TEE_UUID_NS_NAME_SIZE would be.

> +	if (!*data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	exe_file = get_mm_exe_file(current->mm);
> +	if (!exe_file) {
> +		kfree(*data);
> +		return ERR_PTR(-ENOENT);
> +	}
> +
> +	path = file_path(exe_file, *data, TEE_UUID_NS_NAME_SIZE);
> +	fput(exe_file);

I suppose there is a problem with file_path() in here.

It internally uses d_path() and I believe it is subject to chroot() and 
someone could fake it a bit.

So we might want to use d_absolute_path() instead to get absolute path 
that cannot be faked with chroot().

It seems that apparmor, ima and tomoyo is using d_absolute_path() to 
some degree. There are some traces of namespace stuff in those 
frameworks so I am wondering what is the right thing to do here?

> +
> +	if (IS_ERR(path)) {
> +		kfree(*data);
> +		return path;
> +	}
> +
> +	return path;
> +}
> +#endif /* CONFIG_TEE_APPID_PATH */
> +
>   /**
>    * uuid_v5() - Calculate UUIDv5
>    * @uuid: Resulting UUID
> @@ -197,6 +259,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>   	gid_t ns_grp = (gid_t)-1;
>   	kgid_t grp = INVALID_GID;
>   	char *name = NULL;
> +	void *app_id_data = NULL;
> +	const char *app_id = NULL;
>   	int name_len;
>   	int rc;
>   
> @@ -217,6 +281,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>   	 * For TEEC_LOGIN_GROUP:
>   	 * gid=<gid>
>   	 *
> +	 * For TEEC_LOGIN_APPLICATION:
> +	 * app=<application id>
> +	 *
> +	 * For TEEC_LOGIN_USER_APPLICATION:
> +	 * uid=<uid>:app=<application id>
> +	 *
> +	 * For TEEC_LOGIN_GROUP_APPLICATION:
> +	 * gid=<gid>:app=<application id>
>   	 */
>   
>   	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);

If we would move this inside to switch() then each option could handle 
the size how it needs to be handled.

> @@ -227,10 +299,6 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>   	case TEE_IOCTL_LOGIN_USER:
>   		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
>   				    current_euid().val);
> -		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> -			rc = -E2BIG;
> -			goto out_free_name;
> -		}
>   		break;
>   
>   	case TEE_IOCTL_LOGIN_GROUP:
> @@ -243,10 +311,49 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>   
>   		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x",
>   				    grp.val);
> -		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> -			rc = -E2BIG;
> +		break;
> +
> +	case TEE_IOCTL_LOGIN_APPLICATION:
> +		app_id = get_app_id(&app_id_data);
> +		if (IS_ERR(app_id)) {
> +			rc = PTR_ERR(app_id);
> +			goto out_free_name;
> +		}
> +

... then in here we could allocate the right amount of memory and be 
gone for any limits.

name_len = snprintf(NULL, 0, ...);

then

kzalloc(name_len + 1, ...)

and then final snprintf(name, name_len + 1, ...);

Then we would be rid of this artificial TEE_UUID_NS_NAME_SIZE limit.

> +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
> +				    app_id);
> +		kfree(app_id_data);
> +		break;

Thanks,
Vesa Jääskeläinen
