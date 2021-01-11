Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939492F19FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbhAKPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:46:36 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:10216 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730420AbhAKPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:46:35 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10BFRP0M004630;
        Mon, 11 Jan 2021 15:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=97JJXZRhDWVElJuERE6sAiXt5dObsybEu6nL+LLmLF0=;
 b=WdOym7+QGL2Jxe5kZvd+jbvKF2C5Oy7gbJGKcZeTJwHZYAuXkKAgu0w0ZsRaaB61/V5V
 sxgXArLZCKATymLq4P4NMaxha4Db0exkvBUVklXksKJtROplOYWwom3cfZT51tMnY8Vp
 JNbDLYdn3vNtRmWjpHkBUZnFH3jSBAzdO3rn8xbLz8jHQZtcNmuSBuh2/Aa54Em8KHnf
 NeZbSQOAD08ZEMnOiPYB1YUg1+GCs2EDPg7u+C4VmMVYjxBJ3oBzmSimyLnbCNLgOZ/s
 RLoZEN1Iso3XdYQnd6npeQL16saYgJ6avtqfpbxAxUoiCZJC7sl1CWgD+jP+LFcQ0/Xd Kw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 35y5kr46cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 15:45:19 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 527616D;
        Mon, 11 Jan 2021 15:45:18 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.160.247])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id B26943A;
        Mon, 11 Jan 2021 15:45:16 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:45:16 -0600
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
Message-ID: <20210111154516.GH144275@swahl-home.5wahls.com>
References: <20210108153549.108989-1-steve.wahl@hpe.com>
 <20210108153549.108989-3-steve.wahl@hpe.com>
 <X/xL8d8FXVJHkQUj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/xL8d8FXVJHkQUj@hirez.programming.kicks-ass.net>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_26:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:00:33PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 08, 2021 at 09:35:49AM -0600, Steve Wahl wrote:
> 
> 
> > +		/*
> > +		 * The nodeid and idmap registers only contain enough
> > +		 * information to handle 8 nodes.  On systems with more
> > +		 * than 8 nodes, we need to rely on NUMA information,
> > +		 * filled in from BIOS supplied information, to determine
> > +		 * the topology.
> > +		 */
> 
> Egads.. do we realy have to trust BIOS data? BIOS crud tends to be
> bonghits qualitee :/

I work too close to BIOS people (virtually, at least for the moment)
to safely make disparaging remarks. :-) While the origin is the BIOS,
I'm using pieces that were already being pulled from the BIOS tables
for NUMA purposes.  

> > +		if (nr_node_ids <= 8) {
> > +			/* get the Node ID of the local register */
> > +			err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
> > +			if (err)
> > +				break;
> > +			nodeid = config & NODE_ID_MASK;
> > +			/* get the Node ID mapping */
> > +			err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
> > +			if (err)
> > +				break;
> >  
> > +			segment = pci_domain_nr(ubox_dev->bus);
> > +			raw_spin_lock(&pci2phy_map_lock);
> > +			map = __find_pci2phy_map(segment);
> > +			if (!map) {
> > +				raw_spin_unlock(&pci2phy_map_lock);
> > +				err = -ENOMEM;
> > +				break;
> > +			}
> > +
> > +			/*
> > +			 * every three bits in the Node ID mapping register maps
> > +			 * to a particular node.
> > +			 */
> > +			for (i = 0; i < 8; i++) {
> > +				if (nodeid == ((config >> (3 * i)) & 0x7)) {
> > +					if (topology_max_die_per_package() > 1)
> > +						die_id = i;
> > +					else
> > +						die_id = topology_phys_to_logical_pkg(i);
> > +					map->pbus_to_dieid[bus] = die_id;
> > +					break;
> > +				}
> > +			}
> >  			raw_spin_unlock(&pci2phy_map_lock);
> > +		} else {
> > +			int node = pcibus_to_node(ubox_dev->bus);
> > +			int cpu;
> > +
> > +			segment = pci_domain_nr(ubox_dev->bus);
> > +			raw_spin_lock(&pci2phy_map_lock);
> > +			map = __find_pci2phy_map(segment);
> > +			if (!map) {
> > +				raw_spin_unlock(&pci2phy_map_lock);
> > +				err = -ENOMEM;
> > +				break;
> > +			}
> > +			die_id = -1;
> > +			for_each_cpu(cpu, cpumask_of_pcibus(ubox_dev->bus)) {
> > +				struct cpuinfo_x86 *c = &cpu_data(cpu);
> > +
> > +				if (c->initialized && cpu_to_node(cpu) == node) {
> > +					map->pbus_to_dieid[bus] = die_id = c->logical_die_id;
> > +					break;
> > +				}
> > +			}
> > +			raw_spin_unlock(&pci2phy_map_lock);
> > +
> > +			if (WARN_ON_ONCE(die_id == -1)) {
> > +				err = -EINVAL;
> >  				break;
> >  			}
> 
> This seems to assume a single die per node; is that fundemantally
> correct?

It should work for one or more nodes per die; i.e. sub-NUMA clustering
should work.  If there are any systems with fewer nodes than dies
(more than one die in a NUMA node) it will likely fail.  It's not
clear to me whether nodes < dies is a possibility or not; however,
note that this situation would be broken with or without my changes.

> Did you consider malicious BIOS data? I think we're good, but I didn't
> look too hard.

I did not consider malicious BIOS data.  With quick thought toward it,
I believe the worst that could happen is the counters get associated
with the wrong die, and only under circumstances where the previous
code would have aborted mapping the counters to dies completely (which
it does when there are more than 8 dies).

Thank you for taking the time to look at this!

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
