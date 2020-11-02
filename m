Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37B2A35B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgKBVAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:00:49 -0500
Received: from mr85p00im-ztdg06021201.me.com ([17.58.23.189]:36223 "EHLO
        mr85p00im-ztdg06021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbgKBVAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1604350848;
        bh=SD2YVvasW2Pf0gql3y2ggZ9jpbRndaH8mwNPkIMEUB0=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=gzezUJwtJ5gMr7aR4+aCh6QMUjiRmoMtZW6Ts56E5ceAyxa/capktgu/ldnwRWvQi
         AnzH5SPUTQBowxvhoaIzLW/NJBHSgFx33YqJyT1QlGFrhZJyKfgN8jfWFn+UypgwTa
         f93fu+XaNXvjJphPGCsPyFK531QgZWxotVaEmTGA18sbgErUukglRkHG7W/qnRMR0m
         oT+NSCRgDRZquDdS8zGGrhKuLKuryHbXiXvTSuyUcCsPuzd2r9iY7rHW4pYFabBLD6
         BSkWw2Nk8oc7Qn93htKwje+XASTKGeQqLrFvwus0JlcIp33lrA2sGz6ImKaf0FL2cU
         C1nRVhr7LKkMQ==
Received: from [10.88.64.45] (mobile-166-171-248-27.mycingular.net [166.171.248.27])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id EC3CE12059A;
        Mon,  2 Nov 2020 21:00:47 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: simplify get_next_ra_size
From:   =?utf-8?Q?The_Dellia=E2=80=99s?= <denisedellia@icloud.com>
In-Reply-To: <55D84356-9970-4CEB-9602-E245E0AB4A2F@icloud.com>
Date:   Mon, 2 Nov 2020 13:00:46 -0800
Cc:     akpm@linux-foundation.org, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-Id: <647A3ADB-3B40-458C-AD5C-809A8ADB080D@icloud.com>
References: <55D84356-9970-4CEB-9602-E245E0AB4A2F@icloud.com>
To:     hsiangkao@aol.com
X-Mailer: iPhone Mail (18A393)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_15:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=750 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2011020161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuck off

Sent from my iPhone

> On Nov 2, 2020, at 11:01 AM, The Dellia=E2=80=99s <denisedellia@icloud.com=
> wrote:
>=20
> =EF=BB=BF
>=20
>=20
> Sent from my iPhone
