Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868542EFBD0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAHXrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:47:16 -0500
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:8928
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbhAHXrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:47:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkS6vHFBJ91/h/UyxSUx7nU2fJ/LSm/CC8wI2NK+1gpudur2+fmBUzu6H65ZoqodF/dDp+Allzdq9G44osm6q2kwc/Sq6//n7kgZuhk2xuuJZgPxtu5McA3WHZWi+LFeuqoVD+rDn8MaNrqb/kUsMWNpAJdOX2zs4wcOyik7qA5Pdea7FZo10tI9lHfo/MgkqPd6m9cp2Vxzxp9fLCyoICteFo7szQsjkUN3U/fPIr395LDvcviu+yIcKIr+JaL8xoIK8bkR/tTgngpO/cHh88j8yG5r8hnO13MmjgpV1iQXQZw75/J3KddG2Wv5rY5JCg+E86emZ0O1dbZ+9eslug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1zsCMm2IZu7bnrKiFRXZRbBuhc/w6WvrT6pl6zKQeA=;
 b=Erhd/dU+2ibaENvAXTr7EBm1p4Da/bJSoKI4+x9D1NiQeeTkCij6FFFA+EEkxhEB4HY7APO47LzjKzYzgQZHl8+Jf8iKHxsNiFbc7Mp2mWzuhWLsmsyV3i8413pJ+xuKIZxfEEU9uHiBBiPfj1SaJbt7nN9FUvqLU0NPk7PBp4WHKzx+XGLp5pnZGwSJODLa6aEFj2JSBhSUZnjMNk7DBjmVpyv4PiS9/yCeUSdUmtmaMlBj0RHl2oGPecyeRkRUZEbSi8+3RekTfN3/di2FaJjG2GB8eHfeLITkE1VeYG/ErtemNIfFoKBgZ1R5WSwD4t7dZoLtWsi1vBKVOJFJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1zsCMm2IZu7bnrKiFRXZRbBuhc/w6WvrT6pl6zKQeA=;
 b=PUGO06Kjbs7U4SzOZBmQjMczXAVD820QjjxjeEOQGUViDYz2ePX0rzTGK9YWFhBAqpx4MGf5z+pbfGjp3yyJ3rXYxyLfpX6ywWuWIzx4f8obfMpIRnE6ngK16yKVfOMgh2gS7qzRtBHniE/Q2dFtF6EkLNkStKwqaZbNkQl8yRQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 23:46:19 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::9425:559:83c0:991b]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::9425:559:83c0:991b%9]) with mapi id 15.20.3742.011; Fri, 8 Jan 2021
 23:46:19 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix out-of-bounds read in
 kdf_create_vcrat_image_cpu()
To:     Jeremy Cline <jcline@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Kent Russell <kent.russell@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210108163104.411442-1-jcline@redhat.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a341f82d-5933-3df3-f665-cbb4fb5fc5ff@amd.com>
Date:   Fri, 8 Jan 2021 18:46:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210108163104.411442-1-jcline@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 23:46:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0feffba-3fcf-4c91-cda3-08d8b42f98f3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB452014999B92A2830E94B94392AE0@MN2PR12MB4520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yik+0npIL5H+dEAxyhxnyMl7HxOj+26+OM9NmEGq/gCFnoEFursP3YIjxVSc+12G1XN8AWOZsj1frtfQ3rD4D6qNhxxwZu8S/T0HgCXuL2x1SvXocDfLEGYYtVqrbZvdNnj1MPtNVEK3n8OtHvBhEgG7uBiBypwRatGxkCV0Jh57aGaAcCoQv6EB+fnfkmkTJNleN/97IfATfHtFp3FFbFxaRK49seMuSAWpr1+gEOHjNrKkPMYwdkRUkmJ1QDNv1/UH/8hn0sdnL/reDYnB/6+1rpik1ITNVM5bMXOoNyT0brM6YY0K8G+tk+nC5Ld11UGVLdY33Kx5WjajhAf8SfopGBlPmSB0XmMEg4kNyatITuin8eTmXWQe4rcLiZD+cnQh1irFr72Kp8dP19YC8jaNRAHaThMmLDli8Vy7TK8VawQteziP2p9d9t3B4xxeDYotfv06Omlx2DkYTaBkMoEXm4ukbbDZDki3Y/QZZG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(86362001)(186003)(16526019)(2616005)(66556008)(5660300002)(2906002)(31686004)(26005)(956004)(44832011)(31696002)(83380400001)(478600001)(66476007)(316002)(54906003)(52116002)(8676002)(110136005)(6486002)(8936002)(4326008)(66946007)(16576012)(36756003)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHZwNUFucXIwRXFyWmJLd3I4YkdjenYzOS9LQmN5aHdrN0Ywa3B1c2VncEt3?=
 =?utf-8?B?UEwxdHphQmZtSmVGTGhDdGprQlJrcFVNdjlXMTE4a1liQjIveDZXWi84L3ZJ?=
 =?utf-8?B?ckROTyt3M0w4WWwzUHUvZ08yWk9BV2RDSHlIT3h1NEFWUTBEdzVPMjdIVmk3?=
 =?utf-8?B?ZTUrUStmS1hyVEE0UDhtVVN1R0J3RmZxWFlFUUZ1VVBUeUZjcVI0MlBpMHVs?=
 =?utf-8?B?K09LZ25CbnNvOEI0VUE5RElmcFRBT2EzSUthZkVlWmxsZkNjUWdkWlc4YitO?=
 =?utf-8?B?dVRkaXZObHBGTkltZDhoOGpnV2VFa0hFZEtuQWd5TDlHQzVmSXpPeEpaOWM4?=
 =?utf-8?B?MWVQMkNSblZOcUVodm9pUHF2RWI4clFoU3VyQVh0a0ZUc3p4UUdFdXVuWFJh?=
 =?utf-8?B?QWZFS1hFVTZtOUozbDVBdG92UmduWGcxUjQ2cEtNMWJwMWxXYklnV3IrSHgx?=
 =?utf-8?B?eHZPd2tBT1lpK3p4NloxNGZ3RjI1a1RjcXphQTcrcEk4UzNwa2RvelIvMWZt?=
 =?utf-8?B?RjZ1THQwU0oxdEVqODBwa2J1THM1TVZuZk9lWXFyblRlOUpwY0l2YitxL0dx?=
 =?utf-8?B?RHlqemdvbXN2K2h5RHcxd3orUGRnYU4yTVQ0b3E0cWhqSnVVN3BBYVhMNHg0?=
 =?utf-8?B?ZXpQREloZ0ZjQlN4bE5GdWh3NUJ4L2ZlM0hudGFhWms4c3NRbHpYODNHUTZP?=
 =?utf-8?B?SVhzY1NkM3BWOHB2bjZVVFdmaTlSMWVjbDVROFc4aVJxeUZyL3lDaUFlMXEw?=
 =?utf-8?B?Qk1BU1YzMnd0OEFwTHAxZC9wZ3Jna1h3UWV3MVVHSUh4NndydWZtUUIwc1Yw?=
 =?utf-8?B?NDl5UlY3VXpmMGtPampCMGFsNWd1SStjSTVTdXh6MzU2YWNmOWR1TG5BdHNv?=
 =?utf-8?B?d0xGM3AvOGhtb3BxRnZUTmJjYzl6dWNKeURNekRwSHlsOWxXMmkvMHdmbERa?=
 =?utf-8?B?M3RGaStXMzAxOGpEV1BOTzliQ1V1N3ZrQXY0dlhlR0hqdEJsV0U2cFFTeEZX?=
 =?utf-8?B?SnFpOUZ5cXRNQzh4S0tBYXFHV3lQSTJMeW03WHFvak9BRUVJYzF3MG9sZWhy?=
 =?utf-8?B?TzA2MWEzNmE2bjZmd1pzQ3pmNzVQVC9GY2V3Mk9zdDBtWTJsdmJEbm11RW5D?=
 =?utf-8?B?SGxvRlk0QUlKV1JvSU5NSWQvWHZKNU91YXZYQy9PUEk3TS9hM3dLUmExVWhC?=
 =?utf-8?B?ZVdYL2RJUWxMdTZsamZCMFlVZms1cVdZVWZIYTAyRFZZQVp4djlrV1FHZ2VJ?=
 =?utf-8?B?cDNFejNXY3BzU283NFNwQjhtN0Qxc292RG5GRlRjZVIyNVRlV1B0VGMrRnBU?=
 =?utf-8?Q?uTRt3MfZo5hRn05wGCsXqmhp3qEGizEx5J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 23:46:19.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d0feffba-3fcf-4c91-cda3-08d8b42f98f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZFVMwbBXKnV7qbwpef04r5qWcbH5KyEfYwlspmROyEv9XtGBhsHGtKQS6i8tNFLwwu7j0whna+9a9c7M3/VMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-08 um 11:31 a.m. schrieb Jeremy Cline:
> KASAN reported a slab-out-of-bounds read of size 1 in
> kdf_create_vcrat_image_cpu().
>
> This occurs when, for example, when on an x86_64 with a single NUMA node
> because kfd_fill_iolink_info_for_cpu() is a no-op, but afterwards the
> sub_type_hdr->length, which is out-of-bounds, is read and multiplied by
> entries. Fortunately, entries is 0 in this case so the overall
> crat_table->length is still correct.

That's a pretty big change to fix that. Wouldn't it be enough to add a
simple check after calling kfd_fill_iolink_info_for_cpu:

    if (entries) {
    	crat_table->length += (sub_type_hdr->length * entries);
    	crat_table->total_entries += entries;
    }

Or change the output parameters of the kfd_fill_..._for_cpu functions
from num_entries to size_filled, so the caller doesn't need to read
sub_type_hdr->length any more.

Regards,
  Felix


>
> This refactors the helper functions to accept the crat_table directly
> and calculate the table entry pointer based on the current table length.
> This allows us to avoid an out-of-bounds read and hopefully makes the
> pointer arithmetic clearer. It should have no functional change beyond
> removing the out-of-bounds read.
>
> Fixes: b7b6c38529c9 ("drm/amdkfd: Calculate CPU VCRAT size dynamically (v2)")
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 86 +++++++++++++--------------
>  1 file changed, 40 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 8cac497c2c45..e50db2c0f4ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -829,21 +829,24 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  /* kfd_fill_cu_for_cpu - Fill in Compute info for the given CPU NUMA node
>   *
>   *	@numa_node_id: CPU NUMA node id
> - *	@avail_size: Available size in the memory
> - *	@sub_type_hdr: Memory into which compute info will be filled in
> + *	@avail_size: Available space in bytes at the end of the @crat_table.
> + *	@crat_table: The CRAT table to append the Compute info to;
> + *		on success the table length and total_entries count is updated.
>   *
>   *	Return 0 if successful else return -ve value
>   */
>  static int kfd_fill_cu_for_cpu(int numa_node_id, int *avail_size,
> -				int proximity_domain,
> -				struct crat_subtype_computeunit *sub_type_hdr)
> +				struct crat_header *crat_table)
>  {
>  	const struct cpumask *cpumask;
> +	struct crat_subtype_computeunit *sub_type_hdr;
>  
>  	*avail_size -= sizeof(struct crat_subtype_computeunit);
>  	if (*avail_size < 0)
>  		return -ENOMEM;
>  
> +	sub_type_hdr = (typeof(sub_type_hdr))((char *)crat_table +
> +		crat_table->length);
>  	memset(sub_type_hdr, 0, sizeof(struct crat_subtype_computeunit));
>  
>  	/* Fill in subtype header data */
> @@ -855,36 +858,42 @@ static int kfd_fill_cu_for_cpu(int numa_node_id, int *avail_size,
>  
>  	/* Fill in CU data */
>  	sub_type_hdr->flags |= CRAT_CU_FLAGS_CPU_PRESENT;
> -	sub_type_hdr->proximity_domain = proximity_domain;
> +	sub_type_hdr->proximity_domain = crat_table->num_domains;
>  	sub_type_hdr->processor_id_low = kfd_numa_node_to_apic_id(numa_node_id);
>  	if (sub_type_hdr->processor_id_low == -1)
>  		return -EINVAL;
>  
>  	sub_type_hdr->num_cpu_cores = cpumask_weight(cpumask);
>  
> +	crat_table->length += sub_type_hdr->length;
> +	crat_table->total_entries++;
> +
>  	return 0;
>  }
>  
>  /* kfd_fill_mem_info_for_cpu - Fill in Memory info for the given CPU NUMA node
>   *
>   *	@numa_node_id: CPU NUMA node id
> - *	@avail_size: Available size in the memory
> - *	@sub_type_hdr: Memory into which compute info will be filled in
> + *	@avail_size: Available space in bytes at the end of the @crat_table.
> + *	@crat_table: The CRAT table to append the Memory info to;
> + *		on success the table length and total_entries count is updated.
>   *
>   *	Return 0 if successful else return -ve value
>   */
>  static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
> -			int proximity_domain,
> -			struct crat_subtype_memory *sub_type_hdr)
> +			struct crat_header *crat_table)
>  {
>  	uint64_t mem_in_bytes = 0;
>  	pg_data_t *pgdat;
>  	int zone_type;
> +	struct crat_subtype_memory *sub_type_hdr;
>  
>  	*avail_size -= sizeof(struct crat_subtype_memory);
>  	if (*avail_size < 0)
>  		return -ENOMEM;
>  
> +	sub_type_hdr = (typeof(sub_type_hdr))((char *)crat_table +
> +		crat_table->length);
>  	memset(sub_type_hdr, 0, sizeof(struct crat_subtype_memory));
>  
>  	/* Fill in subtype header data */
> @@ -905,27 +914,37 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
>  
>  	sub_type_hdr->length_low = lower_32_bits(mem_in_bytes);
>  	sub_type_hdr->length_high = upper_32_bits(mem_in_bytes);
> -	sub_type_hdr->proximity_domain = proximity_domain;
> +	sub_type_hdr->proximity_domain = crat_table->num_domains;
> +
> +	crat_table->length += sub_type_hdr->length;
> +	crat_table->total_entries++;
>  
>  	return 0;
>  }
>  
>  #ifdef CONFIG_X86_64
> +/* kfd_fill_iolink_info_for_cpu() - Add IO link info to a Virtual CRAT
> + *
> + * @numa_node_id: The NUMA node ID for the CPU; as from for_each_online_node()
> + * @avail_size: Available space in bytes at the end of the @crat_table.
> + * @crat_table: The CRAT table to append the IO link info to; on success the
> + *              table length and total_entries count is updated.
> + *
> + * Return: 0 if successful else return -ve value
> + */
>  static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
> -				uint32_t *num_entries,
> -				struct crat_subtype_iolink *sub_type_hdr)
> +				struct crat_header *crat_table)
>  {
>  	int nid;
>  	struct cpuinfo_x86 *c = &cpu_data(0);
>  	uint8_t link_type;
> +	struct crat_subtype_iolink *sub_type_hdr;
>  
>  	if (c->x86_vendor == X86_VENDOR_AMD)
>  		link_type = CRAT_IOLINK_TYPE_HYPERTRANSPORT;
>  	else
>  		link_type = CRAT_IOLINK_TYPE_QPI_1_1;
>  
> -	*num_entries = 0;
> -
>  	/* Create IO links from this node to other CPU nodes */
>  	for_each_online_node(nid) {
>  		if (nid == numa_node_id) /* node itself */
> @@ -935,6 +954,8 @@ static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
>  		if (*avail_size < 0)
>  			return -ENOMEM;
>  
> +		sub_type_hdr = (typeof(sub_type_hdr))((char *)crat_table +
> +			crat_table->length);
>  		memset(sub_type_hdr, 0, sizeof(struct crat_subtype_iolink));
>  
>  		/* Fill in subtype header data */
> @@ -947,8 +968,8 @@ static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
>  		sub_type_hdr->proximity_domain_to = nid;
>  		sub_type_hdr->io_interface_type = link_type;
>  
> -		(*num_entries)++;
> -		sub_type_hdr++;
> +		crat_table->length += sub_type_hdr->length;
> +		crat_table->total_entries++;
>  	}
>  
>  	return 0;
> @@ -966,12 +987,8 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>  	struct crat_header *crat_table = (struct crat_header *)pcrat_image;
>  	struct acpi_table_header *acpi_table;
>  	acpi_status status;
> -	struct crat_subtype_generic *sub_type_hdr;
>  	int avail_size = *size;
>  	int numa_node_id;
> -#ifdef CONFIG_X86_64
> -	uint32_t entries = 0;
> -#endif
>  	int ret = 0;
>  
>  	if (!pcrat_image)
> @@ -1003,48 +1020,25 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>  	crat_table->total_entries = 0;
>  	crat_table->num_domains = 0;
>  
> -	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
> -
>  	for_each_online_node(numa_node_id) {
>  		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
>  			continue;
>  
>  		/* Fill in Subtype: Compute Unit */
> -		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
> -			crat_table->num_domains,
> -			(struct crat_subtype_computeunit *)sub_type_hdr);
> +		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size, crat_table);
>  		if (ret < 0)
>  			return ret;
> -		crat_table->length += sub_type_hdr->length;
> -		crat_table->total_entries++;
> -
> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> -			sub_type_hdr->length);
>  
>  		/* Fill in Subtype: Memory */
> -		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
> -			crat_table->num_domains,
> -			(struct crat_subtype_memory *)sub_type_hdr);
> +		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size, crat_table);
>  		if (ret < 0)
>  			return ret;
> -		crat_table->length += sub_type_hdr->length;
> -		crat_table->total_entries++;
> -
> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> -			sub_type_hdr->length);
>  
>  		/* Fill in Subtype: IO Link */
>  #ifdef CONFIG_X86_64
> -		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
> -				&entries,
> -				(struct crat_subtype_iolink *)sub_type_hdr);
> +		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size, crat_table);
>  		if (ret < 0)
>  			return ret;
> -		crat_table->length += (sub_type_hdr->length * entries);
> -		crat_table->total_entries += entries;
> -
> -		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
> -				sub_type_hdr->length * entries);
>  #else
>  		pr_info("IO link not available for non x86 platforms\n");
>  #endif
