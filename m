Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5B2B1BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgKMNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:16:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgKMNQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:16:20 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ADD2uUR153810;
        Fri, 13 Nov 2020 08:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ECFI6KPxFa31akuWqpTX1KuNeumCiohWdrUgL9EHF64=;
 b=QXwUdO/G4Vhw90LxesI35YXw6CXjmXMxvAc+VT/0CC6Pp9ktCkZdHQzKBcrFmT4f7o5X
 fo6sZk+/6a38YKSB0eZhkk+3UyXzFV60A58QhDBZdYeKvdQ6nFS7VTHQU2OuJWZQwn59
 z9ZMXTLR//Fg7zxqPuG2l/FkgJ0r+LMbtxJIRIkWdV4IwaLyRWN3/WiDwQTV+mPHOkBk
 3OnS9jsT3JQWGLfiSKWzeefGDJvx+0idhgxJNz8ig8hBf+YYgmC7lKGQNsp4N7cdi5rl
 Scu/kqPSsFBRgIxNqT8xkIVR051klpiH6h8e1kl+sDTUrxKgzo3HSTwuc7LUSGnAVMAs Fw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34sqwrn2r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 08:16:04 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0ADD8HF8011147;
        Fri, 13 Nov 2020 13:16:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 34njuh6qvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Nov 2020 13:16:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0ADDG0Ug1966706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 13:16:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C18042049;
        Fri, 13 Nov 2020 13:16:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E46B742042;
        Fri, 13 Nov 2020 13:15:59 +0000 (GMT)
Received: from [9.171.37.149] (unknown [9.171.37.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Nov 2020 13:15:59 +0000 (GMT)
Subject: Re: [PATCH 0/2] nvme-pic: improve max I/O queue handling
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112145325.GC2573679@dhcp-10-100-145-180.wdc.com>
 <10908f20-7e18-e967-76dd-1a38e216b378@linux.ibm.com>
 <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <c753af20-878a-91ad-c5c2-692016fe2014@linux.ibm.com>
Date:   Fri, 13 Nov 2020 14:15:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201112173634.GA2626470@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/20 6:36 PM, Keith Busch wrote:
> On Thu, Nov 12, 2020 at 04:45:35PM +0100, Niklas Schnelle wrote:
>> You got to get something wrong, I hope in this case it's just the subject
>> of the cover letter :D
> 
> I suppose the change logs could be worded a little better :)

Do you think I should send a v2 with an improved message?
I just realized I'm pretty alone (and wrong) in starting
the commit message body lower case too.
