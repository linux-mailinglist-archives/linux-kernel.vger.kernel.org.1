Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6153C283BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgJEP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:56:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10926 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgJEP42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:56:28 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095FWqNn151652;
        Mon, 5 Oct 2020 11:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7wBHOKqAVY/TIwlQLiaf/bCoDDVvVqftXBrsOnYNkZE=;
 b=duDwl6Ibbxk26vimL0lz2EZHOUuXHGQwP08119IoMqH9M5hMhw4hv0vSx5YP+4ONB1fD
 J7ZPlwpuc71WlDlH7xIdO4ZeVZNfht1tA40zDUM4opHiGPRcx/BSiHXUswKWx1w1y0xL
 2UmWiAuQCnGjS5x97ijAcoLY+LCngLxMd8sfh2stiy6I9cPRUgmd4Kk6qLDEgL+y+SuG
 Gzf4G+DSJTNe0LIxfL3rxGskJrIFDjp7NVrYxMQIM2tsaYcxnoopaJ13gDiUiPG/ZsOB
 tReyXQFIRZADrBOwkGNu57I05+mhWlltyKDgB8MfFJQOPY25wUdhKngOkPDLxrhYyTgn AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340527uenc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:56:15 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 095FXFQ4154233;
        Mon, 5 Oct 2020 11:56:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 340527uemn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 11:56:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095FlP66028100;
        Mon, 5 Oct 2020 15:56:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx82b61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 15:56:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 095FuAdR25887062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Oct 2020 15:56:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D576711C05C;
        Mon,  5 Oct 2020 15:56:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B51711C04A;
        Mon,  5 Oct 2020 15:56:10 +0000 (GMT)
Received: from localhost (unknown [9.145.67.211])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Oct 2020 15:56:10 +0000 (GMT)
Date:   Mon, 5 Oct 2020 17:56:08 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/4] objtool: fix x86 orc generation on big endian
 cross compiles
Message-ID: <your-ad-here.call-01601913368-ext-6150@work.hours>
References: <20201002160114.7yb7z7aeijhchpwl@treble>
 <cover.thread-a8def4.your-ad-here.call-01601818410-ext-7687@work.hours>
 <patch-4.thread-a8def4.git-a8def4f04016.your-ad-here.call-01601818410-ext-7687@work.hours>
 <20201005140328.hpbpkfpx3hmpuapt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005140328.hpbpkfpx3hmpuapt@treble>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_10:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=1 priorityscore=1501 mlxlogscore=901
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 09:03:28AM -0500, Josh Poimboeuf wrote:
> On Sun, Oct 04, 2020 at 04:30:54PM +0200, Vasily Gorbik wrote:
> > @@ -77,8 +78,9 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
> >  	if (entry->feature) {
> >  		unsigned short feature;
> > 
> > -		feature = *(unsigned short *)(sec->data->d_buf + offset +
> > -					      entry->feature);
> > +		feature = bswap_if_needed(*(unsigned short *)(sec->data->d_buf +
> > +							      offset +
> > +							      entry->feature));
> >  		arch_handle_alternative(feature, alt);
> >  	}
> > ---
> >  arch/x86/include/asm/orc_types.h              | 10 +++++
> >  tools/arch/x86/include/asm/orc_types.h        | 10 +++++
> >  .../arch/x86/include/arch_endianness.h        |  9 +++++
> 
> This patch is misformatted.  Almost like it was concatenated with
> itself?

Indeed. I wonder how that could have happened. Sorry for that. I've
resent patches with rebased patch

"objtool: avoid ../ headers includes and name clashes"

on top. This time I checked patches could be applied from outgoing
mailbox before sending it.
