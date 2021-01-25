Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A691C302D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbhAYVCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:02:53 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45210 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbhAYU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:58:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PKt6Pq037855;
        Mon, 25 Jan 2021 20:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=pOZcO6nSLJxfVXnj7nABSasxHyB+2kW7ArzI5P5TE1U=;
 b=vJDWlvYPVYQXhy/JZcgE3WHyXjhDSJw9GZFEkBqGdlWBsx9N3h3aZa1PxnjdaRBmU2M0
 XlSwk7Rj74NOD9Ppnescy2cB7IOuERbs8lzKFhe29rgMbVwpLM3YaWtGY2WjrQ4u2Pes
 rs3wVJLulhMj4+XbDRptps03Ol5ahv+H83JYtIc2Tcusun7CIoCnFC5GVsihXIgg2lSt
 CS81MyE7KHAKqvVfNGoY9oM6dq4/Sq1uMAq3a5AGWSdFH+ahqqoDXgCkSu6Z2ifAGiER
 +13XjAAxtIc++OX9LRROM3JmRWr/EoAV1ImfiJl5z340S9CvQnyQGRk4/dbkl5lZqOo8 CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 3689aafg4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 20:58:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10PKtVhB138383;
        Mon, 25 Jan 2021 20:58:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 368wjqa3ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 20:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai9O7+1jaxvw88sCVatHuqG9fMMmTnPJ5ctVz4Wop+AxQh+05cTvXaUomyIpF6pktbvftCDVD5s3Sl+rcbqDkCrlVt0bkut4kDdT4bisHptRIkVtBRpFNvXHYb9nmKDWpPsCreeBJ/Gl7eCT0RQRPUfo9z/md+xOVKqzgGvUQ7Su5g4WeYlH+i6rIpDuzPUGCjYIIier/coWvOwU4xeDEp1W6Y8aV7Xbf2kIMSGLLuSfypdJ73s13xKkrl5+87eNMo9v06syEIBdIOvr9DJcBeEWe0QK0fwvEMGI5chB9YECAL3ilRhEldM/8KBrHdP/ZPIuNqhOQrOK+6+2CNOIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOZcO6nSLJxfVXnj7nABSasxHyB+2kW7ArzI5P5TE1U=;
 b=e7bpJxEUfKA4lgzCtRRWAyErIyk8Y+8Qx3p49s5YpqVZ6J88xUEG0po+xvsDc4Oq55z8Mu3VaM7qpf6rf0tAB+nMmbmwotwdyntoksQBk/ofM3f3odaechlLEM7kmo8bl+m9msljTi1S3xR1nOpymWjQdGubAc3yUnOfB0NvEC2+ZbLrL1H6ykm7QUvOL97WJUAz4iuFGV8C4bHO+IqnIsJDriHSpOOGp5CNRgAZ5t8B+7d8QDIxVIxFuEvHGd6inq5/wmLOypBR451BWU+fds9ztFjN6lzhcmnZqQY7Kp8mkoJiJkKp7gSb7kU0dBFyvRM9xAVxOppH2tIww2r5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOZcO6nSLJxfVXnj7nABSasxHyB+2kW7ArzI5P5TE1U=;
 b=qgj1Ez/rOK8JOXGrstkGrILnW5KlqmcJfJ2TeiLrAr6Lhi2LD8x3j0FWzuKNZsJ262Riv86q6DfSQYumnv4Zv7DpdDin2XRkx2GMpp5MCtXpN4SXWEyA6sHCIA6P5tOrlxKJLK942vGy0zNdqgfK0XjvYW82o3CwgHn03KMbFpU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2776.namprd10.prod.outlook.com (2603:10b6:a03:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 20:58:03 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%6]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 20:58:03 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 2/2] mm/hugetlb: refactor subpage recording
Date:   Mon, 25 Jan 2021 20:57:44 +0000
Message-Id: <20210125205744.10203-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210125205744.10203-1-joao.m.martins@oracle.com>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:196::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 20:58:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d92f44b2-3a17-46bb-3ae3-08d8c173e7e8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2776687F13FBC22875AC1789BBBD9@BYAPR10MB2776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVmRdsHXAzUhlEsNZoT3df4FvmZHbBUWP1l/JsuR7RPsLSK0VTFU9nb8ZcGS6lMWmrFzc+K4HEH/byuiNC4lpT2YwSvVj+x8btwt3PLzcTDnOv+6OIJnDfK7pSTP5EcSk3nNxBCRC7EErKjv+MTMirUBR1Wu7FL63ZuN4ZlzzpdEgTNMaD6GF7xol0lAqIL8k29D6giXp8GjOsh+nu6CDCSNRQ/GlRUiMnWmiFm1An+8VJvyj5ZzV1cey6CqdwOMUjpjBWkuIBGVNZUOZ3S0s6DHD9QmGHLcwjAXCq+LXQTL3o96aWImN9H+bQqSTZWGQC6G7Pwyhac6vdRuOoKpTRJu9CcRULjDXTLVq6Zj8zQU0Y/D5W4Tlh8TH9/lLQasd9A3UoSu+q6ur6WLXpi+n8N9kZz2mEdMRlpGi0xaXnozU4UEatCBaYCR42rGhrxcgcOSZRyZTHzRV1ta+VA8lxx9sRJAHu45PsMghRmzA96fBJDVGdz+aaHfyKog3Gnqhgk9sTkymjUw1lLyBxOeeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(39860400002)(376002)(136003)(6916009)(478600001)(107886003)(2906002)(1076003)(103116003)(4326008)(52116002)(956004)(83380400001)(6486002)(8676002)(7696005)(316002)(54906003)(86362001)(66946007)(6666004)(186003)(16526019)(66556008)(8936002)(36756003)(66476007)(26005)(5660300002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ssZVv5xHIdPCv46E9NH1ljE06EzHMTVKENFMZs6tzZpfC47u1EnHXxgU3h23?=
 =?us-ascii?Q?sMyxVuNQwQJIHg/y0KxmcM7C9M3FO0KY+RAu3PjGujjoECic1+TB8TTgZA94?=
 =?us-ascii?Q?tCsBqItD4ju4vOR+1bZOxtHNTf0Y4SO65W4TACQBUG4IRd/8LGxbQctDR/yQ?=
 =?us-ascii?Q?4czZGu7p/BaM46imM80rMlOvZggduhq0zkNTfrCm4aL2X4t4ppbVII9xfeW8?=
 =?us-ascii?Q?k8cMa6Sfk1upP98HH2qur3NXpDz9+p3fxveN9DaJjE+0xd+u3fkH1YjpZ0sK?=
 =?us-ascii?Q?jipb6z7YTltOzrmUhGVGDVG9W7rQl6XPiq8melD3ExXRSpad4s5V4OMncDwb?=
 =?us-ascii?Q?fkjVVCb+wg+sSgyWgSy1uskzP+gYtsUbXvaKJBZY2CPaHjA52VLc7mvVX1hn?=
 =?us-ascii?Q?OuccrMe8LDobJZLsYWVFLSr3UhDbhuCHZuBd2jwMTeELkRnV7jdrfUndWWAK?=
 =?us-ascii?Q?9a3jolCzr0mZUTmAEg1qV66IvEUG3bkmgyGUaLid1Cg1sSteeKEeWc1o5uB2?=
 =?us-ascii?Q?zyhQo3Ys7byqik3pUzt6d6Knzn96FAwHEkqFl7JpI3nFsTzeynEh0glJSRHQ?=
 =?us-ascii?Q?8yfQEWETKS6vcZ9hYEYwzs4oGjj+7Hn+VjpMh7NZXu647DO7aG4OWug9gxBv?=
 =?us-ascii?Q?8Y/8FNwZ4C7ThFYv12Nd30Oxf3caQJ+4Kv8KjVsduoKEIxHch0sJXToWTs8i?=
 =?us-ascii?Q?JNJwgMDyLkvh5m2XP22TRRgcsj4RdeCXoKKbUAL17ObMeqgwZYN9lnp/WQy3?=
 =?us-ascii?Q?xtdpKmt/ve3B30AdSUeYOaDLyI7aqox8Wtjf2bVCKM/TCCopIqqh121hpFC1?=
 =?us-ascii?Q?yduFyojXrFq/Mii6XrTJc22VcNIRAz+xn6ImV6xpfivc8HicFBqGJJ80I5zE?=
 =?us-ascii?Q?vaMHcfoiNNbSLg8QOy1F3MAFyQnHE11f1lDGdfA4m6fpsMtxZm6vSGX5EI8Q?=
 =?us-ascii?Q?quDrmKu/01FkUswOwr+8/LTJ3+fXPpqS4duyjdsr0EpI5IWjcntTT8MxgDxk?=
 =?us-ascii?Q?mTRGJQRXI9zH488sCu6YX6E7V0vHX+13vLPyg6P//+6Rz/DZSYMG4bBc/toH?=
 =?us-ascii?Q?Vb1tsJeI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92f44b2-3a17-46bb-3ae3-08d8c173e7e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 20:58:03.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D++TXeNV0php7BYIOKxvbi7OtIbnYdZisE5t75vHF5IpPe7WwF72MbjOosjo2c1Dn3jaR/WISOn8NRk2dmcSbJVIG2V+zI13fM6elOGAFNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2776
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9875 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a given hugepage backing a VA, there's a rather ineficient
loop which is solely responsible for storing subpages in the passed
pages/vmas array. For each subpage we check whether it's within
range or size of @pages and keep incrementing @pfn_offset and a couple
other variables per subpage iteration.

Simplify this logic and minimize ops per iteration to just
store the output page/vma. Instead of incrementing number of @refs
iteratively, we do it through a precalculation of @refs and having
only a tight loop for storing pinned subpages/vmas.

pinning consequently improves considerably, bringing us close to
{pin,get}_user_pages_fast:

 - 16G with 1G huge page size
 gup_test -f /mnt/huge/file -m 16384 -r 10 -L -S -n 512 -w

 PIN_LONGTERM_BENCHMARK: ~11k us -> ~4400 us
 PIN_FAST_BENCHMARK: ~3700 us

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 016addc8e413..1f7a95bc7c87 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4789,6 +4789,20 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	goto out;
 }
 
+static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
+				 int refs, struct page **pages,
+				 struct vm_area_struct **vmas)
+{
+	int nr;
+
+	for (nr = 0; nr < refs; nr++) {
+		if (likely(pages))
+			pages[nr] = page++;
+		if (vmas)
+			vmas[nr] = vma;
+	}
+}
+
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
 			 unsigned long *position, unsigned long *nr_pages,
@@ -4918,28 +4932,16 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 		}
 
-		refs = 0;
+		refs = min3(pages_per_huge_page(h) - pfn_offset,
+			    (vma->vm_end - vaddr) >> PAGE_SHIFT, remainder);
 
-same_page:
-		if (pages)
-			pages[i] = mem_map_offset(page, pfn_offset);
+		if (pages || vmas)
+			record_subpages_vmas(mem_map_offset(page, pfn_offset),
+					     vma, refs,
+					     likely(pages) ? pages + i : NULL,
+					     vmas ? vmas + i : NULL);
 
-		if (vmas)
-			vmas[i] = vma;
-
-		vaddr += PAGE_SIZE;
-		++pfn_offset;
-		--remainder;
-		++i;
-		refs++;
-		if (vaddr < vma->vm_end && remainder &&
-				pfn_offset < pages_per_huge_page(h)) {
-			/*
-			 * We use pfn_offset to avoid touching the pageframes
-			 * of this compound page.
-			 */
-			goto same_page;
-		} else if (pages) {
+		if (pages) {
 			/*
 			 * try_grab_compound_head() should always succeed here,
 			 * because: a) we hold the ptl lock, and b) we've just
@@ -4950,7 +4952,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * any way. So this page must be available at this
 			 * point, unless the page refcount overflowed:
 			 */
-			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i-1],
+			if (WARN_ON_ONCE(!try_grab_compound_head(pages[i],
 								 refs,
 								 flags))) {
 				spin_unlock(ptl);
@@ -4959,6 +4961,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				break;
 			}
 		}
+
+		vaddr += (refs << PAGE_SHIFT);
+		remainder -= refs;
+		i += refs;
+
 		spin_unlock(ptl);
 	}
 	*nr_pages = remainder;
-- 
2.17.1

