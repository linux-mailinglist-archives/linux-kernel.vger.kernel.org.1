Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B01C5BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgEEPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:39:50 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:26048 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729317AbgEEPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:39:50 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045FO3r6007893;
        Tue, 5 May 2020 15:39:46 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 30u64ntfm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 15:39:46 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 73658B9;
        Tue,  5 May 2020 15:39:45 +0000 (UTC)
Received: from hpe.com (unknown [16.99.160.159])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id B14EB4A;
        Tue,  5 May 2020 15:39:44 +0000 (UTC)
Date:   Tue, 5 May 2020 10:39:44 -0500
From:   Dimitri Sivanich <sivanich@hpe.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, Mike Travis <mike.travis@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: x86/uv cleanups
Message-ID: <20200505153944.GD2297@hpe.com>
References: <20200504171527.2845224-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504171527.2845224-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 mlxlogscore=536
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, we do see a need to clean up old code where it exists, but we would like
to assume this responsibility ourselves in order to ensure functional continuity
with externally available open-sourced modules that our customers rely on.  This
code supports current Superdome Flex systems, as well as forthcoming platforms
based on Intel Cooper Lake and Sapphire Rapids processors.  Some cleanup is
already being included as part of a forthcoming patchset in support of the
upcoming Sapphire Rapids platform.

Nacked-by: Dimitri Sivanich <sivanich@hpe.com>

On Mon, May 04, 2020 at 07:15:16PM +0200, Christoph Hellwig wrote:
> Hi x86 maintainers,
> 
> this series removes various exports and sniplets of dead code
> from the x86/uv code.
> 
> Diffstat:
> 
>   8 files changed, 21 insertions(+), 111 deletions(-)
