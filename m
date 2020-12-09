Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B672B2D455F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgLIP1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:27:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6968 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbgLIP1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:27:42 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B9F2B1V042007;
        Wed, 9 Dec 2020 10:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=bxj5CsCxtxMpz5lNlL5hbIkM0NHnfIzM5+9noRfmSSw=;
 b=HaLFQqWWqT5z5IK/3pYdMLX4Sy3UvDFB6mNSg04S1HXhmp1puM3eaBTXs0Iol8gfYj/M
 y6lC53euBhQTG0wNEQhvdwhpxKs3p+FvekDsBjvU/szg7rNdRvKyBGgOcTmSXGRJWaGI
 0FFDchQcLMbcTIGqq+pBwqWjbNqp5rpHS2YqSca9EhJTiRaKoYfd+VDZ3ZgQvPdeTfzX
 k5pBYzuetzFII+OK0CER/xAM4uYr0auZWzOhFQOFwnHfW8ZKX1Fiq5V2vnmHdydsh1gg
 DScEj0rAZbIbWYj0iJo0h+k/j6N37hCo+JNhSAcqayo0cGmXqunF3TkYhvl+TtBawc/m Lg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35ay1jcxrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 10:26:45 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B9FQPnv030224;
        Wed, 9 Dec 2020 15:26:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8q156-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 15:26:43 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B9FPQQr23527736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 15:25:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 518C152057;
        Wed,  9 Dec 2020 15:25:26 +0000 (GMT)
Received: from thinkpad (unknown [9.171.68.150])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id D619752052;
        Wed,  9 Dec 2020 15:25:25 +0000 (GMT)
Date:   Wed, 9 Dec 2020 16:25:24 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        steven.price@arm.com, christophe.leroy@csgroup.eu,
        vgupta@synopsys.com, paul.walmsley@sifive.com
Subject: Re: [PATCH V2 0/2] mm/debug_vm_pgtable: Some minor updates
Message-ID: <20201209162524.549de532@thinkpad>
In-Reply-To: <5ac12290-536d-968c-1ca6-10918403bb8f@arm.com>
References: <1606825169-5229-1-git-send-email-anshuman.khandual@arm.com>
        <5ac12290-536d-968c-1ca6-10918403bb8f@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_13:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1011 mlxlogscore=725
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 08:11:13 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> 
> 
> On 12/1/20 5:49 PM, Anshuman Khandual wrote:
> > This series contains some cleanups and new test suggestions from Catalin
> > from an earlier discussion.
> > 
> > https://lore.kernel.org/linux-mm/20201123142237.GF17833@gaia/
> > 
> > This series is based on v5.10-rc6 and has been tested on arm64 and x86 but
> > has only been build tested on riscv, s390, arc etc. It would be great if
> > folks could test this on these platforms as well. Thank you.
> > 
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Cc: Vineet Gupta <vgupta@synopsys.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> Hello Gerald/Christophe/Vineet/Paul,
> 
> Could you please give this series a quick test on s390, ppc, arc,
> and riscv platforms. Thank you.
> 

Hi Anshuman, works fine for s390.

Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> [s390]
