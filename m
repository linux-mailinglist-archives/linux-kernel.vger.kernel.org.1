Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB952A33AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBTJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:09:28 -0500
Received: from mr85p00im-ztdg06021201.me.com ([17.58.23.189]:34169 "EHLO
        mr85p00im-ztdg06021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgKBTJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:09:28 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 14:09:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1604343716;
        bh=zSpQr2Fu5BqJzEGIaSLX28SzMRTOC0AZjDYMqo2fBEE=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=P7PZs4mFvyAZGovv4YBAKvdMA7IkPXIOsy1ATlsRNOxqhXLf0aefv97+LHOB6fNRo
         tJmdvLYW74k5kgUzgU7NHgs/mgZy40pO8krCxq3qzM0am9lmOfr7qOyf82lj/jbgRI
         1rPRyxVCWLpdBqyDuWtCVitDbdAB69ODpu6NBCsUK7cvyX0KhbfQu+leaC03Q6QtGl
         ltyqdDs94VQ3XbYLLhd9n40kaA+25T1NwHdXnU09KZ9cQzBwhsmImxNLdgHOLV6Wte
         5bV6IYutOQ85aA00zTDo+iCo1p+XPyeRGcVhfeWguKcEgj2pXqeg0tRCEafc4MKIn9
         DZicDy96+oTKQ==
Received: from [10.88.64.45] (mobile-166-171-248-27.mycingular.net [166.171.248.27])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id 7384E120580;
        Mon,  2 Nov 2020 19:01:56 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   =?utf-8?Q?The_Dellia=E2=80=99s?= <denisedellia@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: simplify get_next_ra_size
Date:   Mon, 2 Nov 2020 11:01:55 -0800
Message-Id: <55D84356-9970-4CEB-9602-E245E0AB4A2F@icloud.com>
Cc:     akpm@linux-foundation.org, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
To:     hsiangkao@aol.com
X-Mailer: iPhone Mail (18A393)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_13:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=465 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2011020145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Sent from my iPhone
