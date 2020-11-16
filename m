Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1036E2B4348
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgKPMEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:04:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbgKPMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:04:36 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AGC27jV121478;
        Mon, 16 Nov 2020 07:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pC0Z5DbjDqzptEn3rhV5tiE9IHnrlKXx1UiLvXy9tlY=;
 b=PE8e02HGwFv5YcULxmYwRz5CJzckDTtGbT0u9MCIiP0uXCc7H/kD7HftbppVkXu8ki1q
 5BKQbuGcA8hUJ3fp4gPxpcILGQekc3CClVABmYY3atpEO8tgE1VEs/4k+LRHzQVT0oOY
 nDW3Dl8oJB9dLLpPRNMjBOsNt9/t45QGu0P+1AgNTWodo+1+85xHZWDveAwXDPVFYSDO
 LEMrfMZapwO3cZnXi8IN18FcdW/CkJZuT0QHSyteJ3n4oW6ieJuqH+FNUqiTqgNJ/5j/
 S/62Nt7hkm+FCv1gDk/3EhUOvLrz7FCHLlX+qILceUSm1N6k4hNs8LGMcXuet308uvXX Kw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ujue14b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 07:04:32 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AGC2vOJ028059;
        Mon, 16 Nov 2020 12:04:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8a266-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 12:04:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AGC4S786816290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 12:04:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13D9552050;
        Mon, 16 Nov 2020 12:04:28 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.43.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7034152051;
        Mon, 16 Nov 2020 12:04:27 +0000 (GMT)
Subject: Re: [PATCH v4 04/27] s390: fix kernel-doc markups
From:   Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <4a9df42dfb68aed6b4a4882f6dccabf00ce932cd.1605521731.git.mchehab+huawei@kernel.org>
 <358a9d80-da01-5d91-71d8-57f453ca8617@linux.vnet.ibm.com>
Message-ID: <77b297ff-a5ee-9ba5-54d0-1930a78bd6e5@linux.vnet.ibm.com>
Date:   Mon, 16 Nov 2020 13:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <358a9d80-da01-5d91-71d8-57f453ca8617@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_03:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko/Vasily will pick this up and will be part of the s390-tree patchset.

Regards
Vineeth


On 11/16/20 11:38 AM, Vineeth Vijayan wrote:
> Thank you very much for the fix.
>
> Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>
>
>
>
> On 11/16/20 11:18 AM, Mauro Carvalho Chehab wrote:
>> fix one typo:
>>     ccw driver -> ccw_driver
>>
>> and one function rename.
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>>   arch/s390/include/asm/ccwdev.h | 2 +-
>>   arch/s390/include/asm/cio.h    | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/ccwdev.h 
>> b/arch/s390/include/asm/ccwdev.h
>> index bf605e1fcf6a..0495ac635ed5 100644
>> --- a/arch/s390/include/asm/ccwdev.h
>> +++ b/arch/s390/include/asm/ccwdev.h
>> @@ -100,41 +100,41 @@ struct ccw_device {
>>    */
>>   #define PE_NONE                0x0
>>   #define PE_PATH_GONE            0x1 /* A path is no longer 
>> available. */
>>   #define PE_PATH_AVAILABLE        0x2 /* A path has become available 
>> and
>>                              was successfully verified. */
>>   #define PE_PATHGROUP_ESTABLISHED    0x4 /* A pathgroup was reset 
>> and had
>>                              to be established again. */
>>   #define PE_PATH_FCES_EVENT        0x8 /* The FCES Status of a path has
>>                            * changed. */
>>     /*
>>    * Possible CIO actions triggered by the unit check handler.
>>    */
>>   enum uc_todo {
>>       UC_TODO_RETRY,
>>       UC_TODO_RETRY_ON_NEW_PATH,
>>       UC_TODO_STOP
>>   };
>>     /**
>> - * struct ccw driver - device driver for channel attached devices
>> + * struct ccw_driver - device driver for channel attached devices
>>    * @ids: ids supported by this driver
>>    * @probe: function called on probe
>>    * @remove: function called on remove
>>    * @set_online: called when setting device online
>>    * @set_offline: called when setting device offline
>>    * @notify: notify driver of device state changes
>>    * @path_event: notify driver of channel path events
>>    * @shutdown: called at device shutdown
>>    * @prepare: prepare for pm state transition
>>    * @complete: undo work done in @prepare
>>    * @freeze: callback for freezing during hibernation snapshotting
>>    * @thaw: undo work done in @freeze
>>    * @restore: callback for restoring after hibernation
>>    * @uc_handler: callback for unit check handler
>>    * @driver: embedded device driver structure
>>    * @int_class: interruption class to use for accounting interrupts
>>    */
>>   struct ccw_driver {
>>       struct ccw_device_id *ids;
>>       int (*probe) (struct ccw_device *);
>> diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
>> index e36cb67d2441..ac02df906cae 100644
>> --- a/arch/s390/include/asm/cio.h
>> +++ b/arch/s390/include/asm/cio.h
>> @@ -312,41 +312,41 @@ struct node_descriptor {
>>   /* Device did not respond in time. */
>>   #define CIO_BOXED      0x0010
>>     /**
>>    * struct ccw_dev_id - unique identifier for ccw devices
>>    * @ssid: subchannel set id
>>    * @devno: device number
>>    *
>>    * This structure is not directly based on any hardware structure. The
>>    * hardware identifies a device by its device number and its 
>> subchannel,
>>    * which is in turn identified by its id. In order to get a unique 
>> identifier
>>    * for ccw devices across subchannel sets, @struct ccw_dev_id has been
>>    * introduced.
>>    */
>>   struct ccw_dev_id {
>>       u8 ssid;
>>       u16 devno;
>>   };
>>     /**
>> - * ccw_device_id_is_equal() - compare two ccw_dev_ids
>> + * ccw_dev_id_is_equal() - compare two ccw_dev_ids
>>    * @dev_id1: a ccw_dev_id
>>    * @dev_id2: another ccw_dev_id
>>    * Returns:
>>    *  %1 if the two structures are equal field-by-field,
>>    *  %0 if not.
>>    * Context:
>>    *  any
>>    */
>>   static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
>>                         struct ccw_dev_id *dev_id2)
>>   {
>>       if ((dev_id1->ssid == dev_id2->ssid) &&
>>           (dev_id1->devno == dev_id2->devno))
>>           return 1;
>>       return 0;
>>   }
>>     /**
>>    * pathmask_to_pos() - find the position of the left-most bit in a 
>> pathmask
>>    * @mask: pathmask with at least one bit set
