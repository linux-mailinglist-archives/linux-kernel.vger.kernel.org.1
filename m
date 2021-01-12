Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D82F3AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436929AbhALToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:44:03 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:11152 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436885AbhALToB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:44:01 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CJg34a017257;
        Tue, 12 Jan 2021 19:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=e2NVDJ0fkKozRRKsoGny2R4lYAkhCEjTtrrfBnvFTjg=;
 b=eOw/IeCk0cxjsuymBQ/uvlcmoGsM1F92F/a7Va9ZVNlx9ZWbrHBQVXojgzDA2EopjL3W
 mSW/JUoIvaWdi8d5pUP24W3dVuYADqx0g/QjyNVYVY80Jud5JGIxfpqAMsEBXL726XqR
 2e3x9NqTxLqJDqhUt80AhFv20KWvrHw5S+mVtzHamTCynHwGdf7FEatl1IGnfBkK2EXx
 jzmzvVmnslE8RSEw83CMELUDFXC2l+67Zb/PCuVgLNtxdx6L4XYwbJwbtAak7kYH/ZOo
 vHuhRXgBvhriZyU2Zih66U5mpsqDas0h6QuuMwmWeMz23ZOyGgaWC4i9vL9g00j0HiQE cg== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 361fvwt0ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 19:42:49 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id BCCEB58;
        Tue, 12 Jan 2021 19:42:48 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.160.247])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 067494C;
        Tue, 12 Jan 2021 19:42:46 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:42:46 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, rja_direct@groups.int.hpe.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [PATCH 2/2] perf/x86/intel/uncore: With > 8 nodes, get pci bus
 die id from NUMA info
Message-ID: <20210112194246.GN144275@swahl-home.5wahls.com>
References: <20210108153549.108989-1-steve.wahl@hpe.com>
 <20210108153549.108989-3-steve.wahl@hpe.com>
 <X/xL8d8FXVJHkQUj@hirez.programming.kicks-ass.net>
 <20210111154516.GH144275@swahl-home.5wahls.com>
 <X/27I08f6a6IUp9Z@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/27I08f6a6IUp9Z@hirez.programming.kicks-ass.net>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_15:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 04:07:15PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 11, 2021 at 09:45:16AM -0600, Steve Wahl wrote:
> > On Mon, Jan 11, 2021 at 02:00:33PM +0100, Peter Zijlstra wrote:
> > > On Fri, Jan 08, 2021 at 09:35:49AM -0600, Steve Wahl wrote:
> > > 
> > > 
> > > > +		/*
> > > > +		 * The nodeid and idmap registers only contain enough
> > > > +		 * information to handle 8 nodes.  On systems with more
> > > > +		 * than 8 nodes, we need to rely on NUMA information,
> > > > +		 * filled in from BIOS supplied information, to determine
> > > > +		 * the topology.
> > > > +		 */
> > > 
> > > Egads.. do we realy have to trust BIOS data? BIOS crud tends to be
> > > bonghits qualitee :/
> > 
> > I work too close to BIOS people (virtually, at least for the moment)
> > to safely make disparaging remarks. :-) While the origin is the BIOS,
> > I'm using pieces that were already being pulled from the BIOS tables
> > for NUMA purposes.
> 
> :-) It's just that we've had too much 'fun' with PCI node bindings in
> the past.

I wasn't aware of that, but I understand.  Fortunately, this patch
should't touch cases that aren't already broken (>8 nodes); working
cases continue to use the existing methods.

Thanks!

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
