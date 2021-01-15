Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80692F6F94
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbhAOAeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:34:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55444 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbhAOAeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:34:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10F0F1Sm192568;
        Fri, 15 Jan 2021 00:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EoYf07ye+2pvEM8W2e9X5zV3+hXXa21IpM2ZAyZNnz4=;
 b=XE7kWDv7toO88nfu3YaqyDyntOiUkYXKCmJ+K04xbeuMnf28mzsk2SfsbUs58ZtV7rHt
 St3M57Q6yUYe18yF6RZ/7aNMfBVNIvd8T9WgpIE9jj42WeMhZLV+mreISV9iV310A9fB
 vq5DpFEg8r2DZcqjAkQG368+bB7xUZXxbzIOo4/XXonXNv8H/GDgtFVHiyNewLY+hzm0
 mEcb8+f3ahXUv4WbykEx66HcZbsJ51+ZnOkJtyNbKzsASUru5K1l4snAoewjcITMXEgO
 u3YHq+Wu7isV65gVdsrwUr6akusatrm77HH4/1h8I5LWgDub99aC9UJvYVdcjjor17GL WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg22vm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 00:33:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10F0GErJ137495;
        Fri, 15 Jan 2021 00:33:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 360kf2tnf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 00:33:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10F0XCHX006621;
        Fri, 15 Jan 2021 00:33:12 GMT
Received: from [10.39.240.226] (/10.39.240.226)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jan 2021 16:33:12 -0800
Subject: Re: [PATCH 15/21] x86/xen/pvh: Convert indirect jump to retpoline
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
 <adfa2afe5ddc831017222db9f48ad0fbff17c807.1610652862.git.jpoimboe@redhat.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <f7335fd4-6204-101c-c628-e5f30c9d4463@oracle.com>
Date:   Thu, 14 Jan 2021 19:33:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <adfa2afe5ddc831017222db9f48ad0fbff17c807.1610652862.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/21 2:40 PM, Josh Poimboeuf wrote:
> It's kernel policy to not have (unannotated) indirect jumps because of
> Spectre v2.  This one's probably harmless, but better safe than sorry.
> Convert it to a retpoline.
>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

