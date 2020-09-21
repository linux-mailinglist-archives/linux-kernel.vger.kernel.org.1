Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6851D273389
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIUUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:16:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50978 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgIUUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:16:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LKEfia194172;
        Mon, 21 Sep 2020 20:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Mt+aUTyxqBIgxXWtK4cmF7Dnc9mlrKM0yEoLKj0+Spk=;
 b=ipUuetluqGLj4x4D4uofwZGPTB6fLoOS954lafOzhq3CR8/MgH6+UPa9UqxoRPvh/WgS
 2g8Nvzpph+w6QoqQfVBCMaB33k4i1j6j0rrXV4mbSp8Eud2aTyeUiVA6iEm97UWF8lcK
 vo3KMzc42bBwIFUo60p4D+oXS6VQSIdT4af2qDil01vmdclFxlHFNh1+Eau5Nx8NCM8v
 7e295FyA/vQ/by6m9alI1IX5CJGnBAPHO6PYsIPBwAONfEYST2mwFPUlbeHAzfPif/yh
 B/UZ7br8ka7IsZfE2cYBD6fqx6RWq+gqMBONsMxmAHSvGLtk+j/0D++pAxVdp2A9M5iG Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnu8nk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 20:16:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LKFmOR190268;
        Mon, 21 Sep 2020 20:16:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33nuw1ssb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 20:16:46 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08LKGhMU001821;
        Mon, 21 Sep 2020 20:16:44 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 13:16:43 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 34DB86A012C; Mon, 21 Sep 2020 16:18:12 -0400 (EDT)
Date:   Mon, 21 Sep 2020 16:18:12 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Young <dyoung@redhat.com>, bhe@redhat.com,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Eric DeVolder <eric.devolder@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Message-ID: <20200921201811.GB3437@char.us.oracle.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> wrote:
> 
> > crash_kexec_post_notifiers enables running various panic notifier
> > before kdump kernel booting. This increases risks of kdump failure.
> > It is well documented in kernel-parameters.txt. We do not suggest
> > people to enable it together with kdump unless he/she is really sure.
> > This is also not suggested to be enabled by default when users are
> > not aware in distributions.
> > 
> > But unfortunately it is enabled by default in systemd, see below
> > discussions in a systemd report, we can not convince systemd to change
> > it:
> > https://github.com/systemd/systemd/issues/16661
> > 
> > Actually we have got reports about kdump kernel hangs in both s390x
> > and powerpcle cases caused by the systemd change,  also some x86 cases
> > could also be caused by the same (although that is in Hyper-V code
> > instead of systemd, that need to be addressed separately).

Perhaps it may be better to fix the issus on s390x and PowerPC as well?

> > 
> > Thus to avoid the auto enablement here just disable the param writable
> > permission in sysfs.
> > 
> 
> Well.  I don't think this is at all a desirable way of resolving a
> disagreement with the systemd developers
> 
> At the above github address I'm seeing "ryncsn added a commit to
> ryncsn/systemd that referenced this issue 9 days ago", "pstore: don't
> enable crash_kexec_post_notifiers by default".  So didn't that address
> the issue?

It does in systemd, but there is a strong interest in making this on by default.
