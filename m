Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7B1EA63D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 16:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFAOrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 10:47:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgFAOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:47:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 051Ek2bB135572;
        Mon, 1 Jun 2020 10:46:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bm15jwv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jun 2020 10:46:20 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 051EkETP136822;
        Mon, 1 Jun 2020 10:46:19 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bm15jwu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jun 2020 10:46:19 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 051Edxwd013432;
        Mon, 1 Jun 2020 14:46:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 31bf47v92e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jun 2020 14:46:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 051EkEBu56819942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jun 2020 14:46:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C58164C046;
        Mon,  1 Jun 2020 14:46:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52DFD4C04A;
        Mon,  1 Jun 2020 14:46:10 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.63.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  1 Jun 2020 14:46:10 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 01 Jun 2020 20:16:08 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Santosh Sivaraj <santosh@fossix.org>, linux-nvdimm@lists.01.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/5] seq_buf: Export seq_buf_printf
In-Reply-To: <20200601094842.3cd0cab6@gandalf.local.home>
References: <20200527041244.37821-1-vaibhav@linux.ibm.com> <20200527041244.37821-3-vaibhav@linux.ibm.com> <87367f9eqs.fsf@linux.ibm.com> <20200601094842.3cd0cab6@gandalf.local.home>
Date:   Mon, 01 Jun 2020 20:16:08 +0530
Message-ID: <87zh9m974f.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-01_10:2020-06-01,2020-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 cotscore=-2147483648 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006010103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 01 Jun 2020 17:31:31 +0530
> Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
>> Hi Christoph and Steven,
>> 
>> Have addressed your review comment to update the patch description and
>> title for this patch. Can you please provide your ack to this patch.
>> 
>> 
>
> I thought I already did, but it appears it was a reply to a private email
> you sent to me. I didn't realize it was off list.
>
> Anyway:
>
>  Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks Steven,

Had added your ack to Resend-v7 of this patch at [1] on which Christoph
Hellwig requested an update of patch title. Hence needed your re-ack for
this version of the patch

[1] : https://lore.kernel.org/linux-nvdimm/20200519190058.257981-3-vaibhav@linux.ibm.com/

>
> -- Steve

Cheers
~ Vaibhav
