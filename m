Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5D82F6F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbhAOAdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:33:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731125AbhAOAdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:33:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10F0FkY3106022;
        Fri, 15 Jan 2021 00:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OA6GdvJeqiN4Ph3TVwCUQIibKNIxhmsnzDhfaxhSSd4=;
 b=EWZcynLCowbu9rX+cj3jBjjM2whgUpxLbHa+2O5MKU2OeS+g2Lege4r14BE5I8B8HFdu
 MdFub0hCUKl8UfvTbFxiN1jRsh1XCDnnilh1MlL66ldDAzPLp/BzukDXd/wfX1M7/DeX
 sNHZRh1vmvTCnoxak3w2GTEONd0ZihJvi/eBC55FNqua7YqQ0p7H6JdhLvxGpy4WApm8
 1UltPUNKj6GQMWw6HJZHdhgiEymd4BOfssP3PLh3KIvGoaEjjBEEDme65l0af8flYYDu
 VSGHUufA2xYObEKY1KzTOp+2astBvOT/8OzKNq+sT/v/1VUPdph94rqmQwFTYdvorBCO lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvkasqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 00:32:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10F0EuK7184276;
        Fri, 15 Jan 2021 00:32:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 360kep1y75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 00:32:37 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10F0WZFP005885;
        Fri, 15 Jan 2021 00:32:35 GMT
Received: from [10.39.240.226] (/10.39.240.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jan 2021 16:32:35 -0800
Subject: Re: [PATCH 14/21] x86/xen: Support objtool vmlinux.o validation in
 xen-head.S
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Miroslav Benes <mbenes@suse.cz>,
        Juergen Gross <jgross@suse.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <02a3b646aa20035c9c700c5b6d7897a9f898ba24.1610652862.git.jpoimboe@redhat.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <e3595399-eef1-bb9c-261d-f09f8b163396@oracle.com>
Date:   Thu, 14 Jan 2021 19:32:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <02a3b646aa20035c9c700c5b6d7897a9f898ba24.1610652862.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/21 2:40 PM, Josh Poimboeuf wrote:
> The Xen hypercall page is filled with zeros, causing objtool to fall
> through all the empty hypercall functions until it reaches a real
> function, resulting in a stack state mismatch.
>
> The build-time contents of the hypercall page don't matter, since it
> gets mapped to the hypervisor.  Make it more palatable to objtool by
> making each hypervisor function a true empty function, with nops and a
> return.
>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

