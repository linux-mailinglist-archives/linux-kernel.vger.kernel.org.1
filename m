Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9572EAA3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbhAELzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:55:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36924 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAELzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:55:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105BmrfW133587;
        Tue, 5 Jan 2021 11:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=M2bss34iyTdCgUkE9jjRxCz2msDHPu7nsOY5jZS56zo=;
 b=ujc08EEk2LVWLRROByqfoV2LYYrtWBgWA7Nv8xADzivMG1khtH49K3U89wIP9VucFsk4
 z+kvjM5DcU6GKAqLgyRl/QqXVFuIU7iAniTdx1ltNlfj9xmyyMTtwconIsqacXd/VBgd
 NpTePkAycZa7De8JPcB7QkiDk0A1NNI6LwRUydPJoufapSwEHd+YbBlAAVRGYx2Y+PbI
 JeC2eM2zXCtX/S4DsOdBEHuNRUqbFimZWdNxLJbeMDs2Ug/z31XWaNTanTZftluWa5kX
 Y4s7H55MYMkB8LEswJKoBdVFXWRDgEABFDjoNPiuJ7k+UI5qmDeN0Vhvq+h65lfYLiGA iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35tgskre9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 11:54:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105BoLLF056623;
        Tue, 5 Jan 2021 11:54:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35uxnsj6ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 11:54:28 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 105BsRbV018087;
        Tue, 5 Jan 2021 11:54:27 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 11:54:26 +0000
Date:   Tue, 5 Jan 2021 14:52:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jovin555 <jovin555@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword
Message-ID: <20210105115233.GA2809@kadam>
References: <20201228051301.14983-1-jovin555@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228051301.14983-1-jovin555@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=940 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=964
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 12:13:00AM -0500, jovin555 wrote:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: jovin555 <jovin555@gmail.com>

Your Mama didn't name you "jovin555".  You need to use your real name
like signing a legal document.  Same for the "From:" header.

regards,
dan carpenter

