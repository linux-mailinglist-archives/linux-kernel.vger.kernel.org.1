Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2816A2F6F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbhAOAcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:32:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51304 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbhAOAcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:32:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10F0FAJn024525;
        Fri, 15 Jan 2021 00:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tpp23TTcS905xSBNUJ3I3+T2xpc999AWSyIQrUjVakI=;
 b=ttbobd2Rnzmgau77uQx5N4KO/UZKityrdKagicxXLHvE43cjOsh0BENxPOexSFUoALBe
 7OIqV7F81qFz1XOoUy1tzOVlMo2LS8jWk5as2bWomMLzQB+H0OeCnFU39xA79qT0Ay+q
 VtVfu2+0PanU7Wo7BSlgotKwZZFEvoJUkFvplzVfYlMs2/DH3HxpG5Ti7rkjorlQus8U
 RBmbZxaaqbAB31MKxksdvt5R5l/AuNH9qXDQyTj/mbq1rQTUI/CLy8uLt22WKVxwFj0Q
 Bw5sUTmzUK9Cd4g+Dw2LNgaX0oQDlTU5zBjrQs+Q+EuBpQq7DdaCnI2mllBjQFZlWU5X aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kd02u5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 00:31:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10F0GGro137727;
        Fri, 15 Jan 2021 00:31:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 360kf2tkfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 00:31:07 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10F0V5St004164;
        Fri, 15 Jan 2021 00:31:05 GMT
Received: from [10.39.240.226] (/10.39.240.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jan 2021 16:31:05 -0800
Subject: Re: [PATCH 13/21] x86/xen: Support objtool validation in xen-asm.S
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
 <77629463ea258e47d8d53bc8947da24dd2923931.1610652862.git.jpoimboe@redhat.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <46bd6b10-6d8a-1065-069e-565c45af7128@oracle.com>
Date:   Thu, 14 Jan 2021 19:31:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <77629463ea258e47d8d53bc8947da24dd2923931.1610652862.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/21 2:40 PM, Josh Poimboeuf wrote:
> The OBJECT_FILES_NON_STANDARD annotation is used to tell objtool to
> ignore a file.  File-level ignores won't work when validating vmlinux.o.
>
> Tweak the ELF metadata and unwind hints to allow objtool to follow the
> code.
>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
