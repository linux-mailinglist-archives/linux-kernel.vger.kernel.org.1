Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A542745E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIVQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:00:46 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:43050 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726566AbgIVQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:00:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 43F3E18015E14;
        Tue, 22 Sep 2020 16:00:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:327:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1981:2194:2196:2198:2199:2200:2201:2393:2559:2562:2693:2731:2737:2828:2892:2893:2895:2896:2897:2899:2900:2904:2914:2915:2922:2923:2924:2925:2926:3138:3139:3140:3141:3142:3167:3622:3865:3866:3867:3868:3870:3872:3874:4321:5007:6119:7903:7974:9038:10004:10394:10848:11232:11658:11914:12043:12048:12291:12297:12555:12683:12740:12760:12895:12986:13019:13141:13146:13230:13439:13869:13972:14096:14097:14659:21063:21080:21324:21433:21611:21627:21740:21789:21795:21809:21966:21972:21990:30051:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: thumb40_0d0ac212714f
X-Filterd-Recvd-Size: 21579
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Sep 2020 16:00:42 +0000 (UTC)
Message-ID: <5c108605003d8ee48665ce616ec31c599c7f0c39.camel@perches.com>
Subject: Re: [PATCH] scripts: increase error-prone spell checking
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Wang Qing <wangqing@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        David Hildenbrand <david@redhat.com>,
        SeongJae Park <sjpark@amazon.de>, Xiong <xndchn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Sep 2020 09:00:40 -0700
In-Reply-To: <ff5dbd13-86c1-89f6-2741-19dd49fdadcf@infradead.org>
References: <1600773524-3158-1-git-send-email-wangqing@vivo.com>
         <ff5dbd13-86c1-89f6-2741-19dd49fdadcf@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-22 at 07:37 -0700, Randy Dunlap wrote:
> On 9/22/20 4:18 AM, Wang Qing wrote:
> > Increase direcly,ununsed,manger spelling error check
> > 
> > Signed-off-by: Wang Qing <wangqing@vivo.com>
> > ---
> >  scripts/spelling.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> > index f253681..91ab82b
> > --- a/scripts/spelling.txt
> > +++ b/scripts/spelling.txt
> > @@ -1534,3 +1534,6 @@ writting||writing
> >  wtih||with
> >  zombe||zombie
> >  zomebie||zombie
> > +direcly||directly
> > +ununsed||unused
> > +manger||manager
> > \ No newline at end of file
> > 
> 
> Uh, that file was in alphabetical order. Please try to keep it that way.

More or less, but not completely.
It's somewhat grouped by desired correction,
but it's also somewhat random.

Here's a sorted diff:
---
 scripts/spelling.txt | 204 +++++++++++++++++++++++++--------------------------
 1 file changed, 102 insertions(+), 102 deletions(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index b703e4fd51e8..f1b15a7ad1e7 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -53,19 +53,19 @@ acknowledgement||acknowledgment
 ackowledge||acknowledge
 ackowledged||acknowledged
 acording||according
-activete||activate
 actived||activated
+activete||activate
 actualy||actually
 acumulating||accumulating
 acumulative||accumulative
 acumulator||accumulator
 acutally||actually
 adapater||adapter
+adddress||address
 addional||additional
 additionaly||additionally
 additonal||additional
 addres||address
-adddress||address
 addreses||addresses
 addresss||address
 addrress||address
@@ -88,9 +88,9 @@ alegorical||allegorical
 algined||aligned
 algorith||algorithm
 algorithmical||algorithmically
+algorithmn||algorithm
 algoritm||algorithm
 algoritms||algorithms
-algorithmn||algorithm
 algorrithm||algorithm
 algorritm||algorithm
 aligment||alignment
@@ -119,16 +119,16 @@ amoung||among
 amout||amount
 amplifer||amplifier
 amplifyer||amplifier
-an union||a union
-an user||a user
-an userspace||a userspace
-an one||a one
 analysator||analyzer
 ang||and
 anniversery||anniversary
 annoucement||announcement
 anomolies||anomalies
 anomoly||anomaly
+an one||a one
+an union||a union
+an user||a user
+an userspace||a userspace
 anway||anyway
 aplication||application
 appearence||appearance
@@ -171,24 +171,24 @@ assum||assume
 assumtpion||assumption
 asuming||assuming
 asycronous||asynchronous
-asynchnous||asynchronous
-asynchromous||asynchronous
 asymetric||asymmetric
 asymmeric||asymmetric
+asynchnous||asynchronous
+asynchromous||asynchronous
+atempt||attempt
 atomatically||automatically
 atomicly||atomically
-atempt||attempt
 attachement||attachment
 attatch||attach
 attched||attached
 attemp||attempt
-attemps||attempts
 attemping||attempting
+attemps||attempts
 attepmpt||attempt
 attnetion||attention
 attruibutes||attributes
-authentification||authentication
 authenicated||authenticated
+authentification||authentication
 automaticaly||automatically
 automaticly||automatically
 automatize||automate
@@ -261,16 +261,16 @@ capabilties||capabilities
 capabilty||capability
 capabitilies||capabilities
 capablity||capability
-capatibilities||capabilities
 capapbilities||capabilities
+capatibilities||capabilities
 caputure||capture
 carefuly||carefully
 cariage||carriage
 catagory||category
 cehck||check
+chache||cache
 challange||challenge
 challanges||challenges
-chache||cache
 chanell||channel
 changable||changeable
 chanined||chained
@@ -314,9 +314,6 @@ commited||committed
 commiting||committing
 committ||commit
 commoditiy||commodity
-comsume||consume
-comsumer||consumer
-comsuming||consuming
 compability||compatibility
 compaibility||compatibility
 comparsion||comparison
@@ -332,12 +329,15 @@ compleatly||completely
 completition||completion
 completly||completely
 complient||compliant
-componnents||components
 compoment||component
+componnents||components
 comppatible||compatible
 compres||compress
 compresion||compression
 comression||compression
+comsume||consume
+comsumer||consumer
+comsuming||consuming
 comunication||communication
 conbination||combination
 conditionaly||conditionally
@@ -372,13 +372,13 @@ continious||continuous
 continous||continuous
 continously||continuously
 continueing||continuing
-contraints||constraints
-contruct||construct
 contol||control
 contoller||controller
+contraints||constraints
 controled||controlled
 controler||controller
 controll||control
+contruct||construct
 contruction||construction
 contry||country
 conuntry||country
@@ -405,8 +405,8 @@ debouce||debounce
 decendant||descendant
 decendants||descendants
 decompres||decompress
-decsribed||described
 decription||description
+decsribed||described
 dectected||detected
 defailt||default
 deferal||deferral
@@ -418,9 +418,9 @@ defintion||definition
 defintions||definitions
 defualt||default
 defult||default
-deintializing||deinitializing
-deintialize||deinitialize
 deintialized||deinitialized
+deintialize||deinitialize
+deintializing||deinitializing
 deivce||device
 delared||declared
 delare||declare
@@ -428,8 +428,8 @@ delares||declares
 delaring||declaring
 delemiter||delimiter
 delievered||delivered
-demodualtor||demodulator
 demension||dimension
+demodualtor||demodulator
 dependancies||dependencies
 dependancy||dependency
 dependant||dependent
@@ -444,9 +444,9 @@ descripton||description
 descrition||description
 descritptor||descriptor
 desctiptor||descriptor
+desination||destination
 desriptor||descriptor
 desriptors||descriptors
-desination||destination
 destionation||destination
 destoried||destroyed
 destory||destroy
@@ -470,32 +470,32 @@ dicline||decline
 dictionnary||dictionary
 didnt||didn't
 diferent||different
+differenciate||differentiate
 differrence||difference
 diffrent||different
-differenciate||differentiate
 diffrentiate||differentiate
 difinition||definition
 digial||digital
 dimention||dimension
 dimesions||dimensions
-disgest||digest
-dispalying||displaying
 diplay||display
 directon||direction
 direectly||directly
 diregard||disregard
-disassocation||disassociation
 disapear||disappear
 disapeared||disappeared
 disappared||disappeared
-disbale||disable
+disassocation||disassociation
 disbaled||disabled
-disble||disable
+disbale||disable
 disbled||disabled
+disble||disable
 disconnet||disconnect
 discontinous||discontinuous
+disgest||digest
 disharge||discharge
 disnabled||disabled
+dispalying||displaying
 dispertion||dispersion
 dissapears||disappears
 dissconect||disconnect
@@ -542,13 +542,13 @@ encryptio||encryption
 endianess||endianness
 enhaced||enhanced
 enlightnment||enlightenment
+enocded||encoded
+enought||enough
 enqueing||enqueuing
+enterily||entirely
 entires||entries
 entites||entities
 entrys||entries
-enocded||encoded
-enought||enough
-enterily||entirely
 enviroiment||environment
 enviroment||environment
 environement||environment
@@ -583,28 +583,28 @@ expecially||especially
 experies||expires
 explicite||explicit
 explicitely||explicitly
-explict||explicit
 explictely||explicitly
+explict||explicit
 explictly||explicitly
 expresion||expression
 exprimental||experimental
-extened||extended
 exteneded||extended||extended
+extened||extended
 extensability||extensibility
-extention||extension
 extenstion||extension
+extention||extension
 extracter||extractor
 faied||failed
 faield||failed
-faild||failed
 failded||failed
+faild||failed
 failer||failure
-faill||fail
 failied||failed
+faill||fail
 faillure||failure
+failng||failing
 failue||failure
 failuer||failure
-failng||failing
 faireness||fairness
 falied||failed
 faliure||failure
@@ -618,14 +618,14 @@ fetaures||features
 fileystem||filesystem
 fimrware||firmware
 fimware||firmware
-firmare||firmware
-firmaware||firmware
-firware||firmware
-firwmare||firmware
 finanize||finalize
 findn||find
 finilizes||finalizes
 finsih||finish
+firmare||firmware
+firmaware||firmware
+firware||firmware
+firwmare||firmware
 flusing||flushing
 folloing||following
 followign||following
@@ -639,8 +639,8 @@ forwardig||forwarding
 frambuffer||framebuffer
 framming||framing
 framwork||framework
-frequncy||frequency
 frequancy||frequency
+frequncy||frequency
 frome||from
 fucntion||function
 fuction||function
@@ -661,9 +661,9 @@ gatable||gateable
 gateing||gating
 gauage||gauge
 gaurenteed||guaranteed
-generiously||generously
 genereate||generate
 genereted||generated
+generiously||generously
 genric||generic
 globel||global
 grabing||grabbing
@@ -686,19 +686,18 @@ havind||having
 heirarchically||hierarchically
 helpfull||helpful
 hexdecimal||hexadecimal
-hybernate||hibernate
 hierachy||hierarchy
 hierarchie||hierarchy
 homogenous||homogeneous
 howver||however
 hsould||should
+hybernate||hibernate
 hypervior||hypervisor
 hypter||hyper
 identidier||identifier
 iligal||illegal
-illigal||illegal
 illgal||illegal
-iomaped||iomapped
+illigal||illegal
 imblance||imbalance
 immeadiately||immediately
 immedaite||immediate
@@ -713,13 +712,14 @@ implemantation||implementation
 implemenation||implementation
 implementaiton||implementation
 implementated||implemented
-implemention||implementation
 implementd||implemented
+implemention||implementation
 implemetation||implementation
 implemntation||implementation
 implentation||implementation
 implmentation||implementation
 implmenting||implementing
+inavlid||invalid
 incative||inactive
 incomming||incoming
 incompatabilities||incompatibilities
@@ -746,29 +746,29 @@ informtion||information
 infromation||information
 ingore||ignore
 inital||initial
-initalized||initialized
 initalised||initialized
 initalise||initialize
+initalized||initialized
 initalize||initialize
 initation||initiation
 initators||initiators
 initialiazation||initialization
 initializationg||initialization
 initializiation||initialization
-initialze||initialize
 initialzed||initialized
+initialze||initialize
 initialzing||initializing
 initilization||initialization
+initilized||initialized
 initilize||initialize
 initliaze||initialize
-initilized||initialized
 inofficial||unofficial
 inrerface||interface
 insititute||institute
 instace||instance
 instal||install
-instanciate||instantiate
 instanciated||instantiated
+instanciate||instantiate
 insufficent||insufficient
 inteface||interface
 integreated||integrated
@@ -783,15 +783,15 @@ interger||integer
 intermittant||intermittent
 internel||internal
 interoprability||interoperability
-interuupt||interrupt
-interupt||interrupt
-interupts||interrupts
 interrface||interface
 interrrupt||interrupt
 interrup||interrupt
 interrups||interrupts
 interruptted||interrupted
 interupted||interrupted
+interupt||interrupt
+interupts||interrupts
+interuupt||interrupt
 intial||initial
 intialisation||initialisation
 intialised||initialised
@@ -804,18 +804,18 @@ intrerrupt||interrupt
 intrrupt||interrupt
 intterrupt||interrupt
 intuative||intuitive
-inavlid||invalid
 invaid||invalid
 invaild||invalid
 invailid||invalid
-invald||invalid
 invalde||invalid
+invald||invalid
 invalide||invalid
 invalidiate||invalidate
 invalud||invalid
 invididual||individual
 invokation||invocation
 invokations||invocations
+iomaped||iomapped
 ireelevant||irrelevant
 irrelevent||irrelevant
 isnt||isn't
@@ -859,11 +859,11 @@ losted||lost
 maangement||management
 machinary||machinery
 maibox||mailbox
+mailformed||malformed
 maintainance||maintenance
 maintainence||maintenance
 maintan||maintain
 makeing||making
-mailformed||malformed
 malplaced||misplaced
 malplace||misplace
 managable||manageable
@@ -883,6 +883,7 @@ meetign||meeting
 memeory||memory
 memmber||member
 memoery||memory
+memomry||memory
 ment||meant
 mergable||mergeable
 mesage||message
@@ -895,17 +896,17 @@ micropone||microphone
 microprocesspr||microprocessor
 migrateable||migratable
 milliseonds||milliseconds
-minium||minimum
 minimam||minimum
+minium||minimum
 miniumum||minimum
 minumum||minimum
 misalinged||misaligned
 miscelleneous||miscellaneous
 misformed||malformed
-mispelled||misspelled
-mispelt||misspelt
 mising||missing
 mismactch||mismatch
+mispelled||misspelled
+mispelt||misspelt
 missign||missing
 missmanaged||mismanaged
 missmatch||mismatch
@@ -917,17 +918,16 @@ modfiy||modify
 modifer||modifier
 modulues||modules
 momery||memory
-memomry||memory
 monitring||monitoring
 monochorome||monochrome
 monochromo||monochrome
 monocrome||monochrome
 mopdule||module
 mroe||more
-multipler||multiplier
 mulitplied||multiplied
 multidimensionnal||multidimensional
 multipe||multiple
+multipler||multiplier
 multple||multiple
 mumber||number
 muticast||multicast
@@ -967,10 +967,10 @@ occured||occurred
 occurence||occurrence
 occure||occurred
 occuring||occurring
-offser||offset
 offet||offset
 offlaod||offload
 offloded||offloaded
+offser||offset
 offseting||offsetting
 omited||omitted
 omiting||omitting
@@ -985,20 +985,20 @@ optionnal||optional
 optmizations||optimizations
 orientatied||orientated
 orientied||oriented
-orignal||original
 originial||original
+orignal||original
 otherise||otherwise
 ouput||output
 oustanding||outstanding
 overaall||overall
 overhread||overhead
-overlaping||overlapping
 overide||override
+overlaping||overlapping
 overrided||overridden
 overriden||overridden
 overun||overrun
-overwritting||overwriting
 overwriten||overwritten
+overwritting||overwriting
 pacakge||package
 pachage||package
 packacge||package
@@ -1010,8 +1010,8 @@ paket||packet
 pallette||palette
 paln||plan
 paramameters||parameters
-paramaters||parameters
 paramater||parameter
+paramaters||parameters
 parametes||parameters
 parametised||parametrised
 paramter||parameter
@@ -1085,8 +1085,8 @@ probaly||probably
 procceed||proceed
 proccesors||processors
 procesed||processed
-proces||process
 procesing||processing
+proces||process
 processessing||processing
 processess||processes
 processpr||processor
@@ -1104,6 +1104,7 @@ progresss||progress
 prohibitted||prohibited
 prohibitting||prohibiting
 promiscous||promiscuous
+promixity||proximity
 promps||prompts
 pronnounced||pronounced
 prononciation||pronunciation
@@ -1112,15 +1113,14 @@ pronunce||pronounce
 propery||property
 propigate||propagate
 propigation||propagation
-propogation||propagation
 propogate||propagate
+propogation||propagation
 prosess||process
 protable||portable
 protcol||protocol
 protecion||protection
 protedcted||protected
 protocoll||protocol
-promixity||proximity
 psudo||pseudo
 psuedo||pseudo
 psychadelic||psychedelic
@@ -1158,8 +1158,8 @@ refernces||references
 refernnce||reference
 refrence||reference
 registed||registered
-registerd||registered
 registeration||registration
+registerd||registered
 registeresd||registered
 registerred||registered
 registes||registers
@@ -1189,8 +1189,8 @@ requiere||require
 requirment||requirement
 requred||required
 requried||required
-requst||request
 requsted||requested
+requst||request
 reregisteration||reregistration
 reseting||resetting
 reseved||reserved
@@ -1210,11 +1210,11 @@ retransmited||retransmitted
 retreived||retrieved
 retreive||retrieve
 retreiving||retrieving
-retrive||retrieve
 retrived||retrieved
+retrive||retrieve
 retrun||return
-retun||return
 retuned||returned
+retun||return
 reudce||reduce
 reuest||request
 reuqest||request
@@ -1256,9 +1256,9 @@ seperate||separate
 seperatly||separately
 seperator||separator
 sepperate||separate
-seqeunce||sequence
-seqeuncer||sequencer
 seqeuencer||sequencer
+seqeuncer||sequencer
+seqeunce||sequence
 sequece||sequence
 sequencial||sequential
 serivce||service
@@ -1321,21 +1321,21 @@ stoppped||stopped
 straming||streaming
 struc||struct
 structres||structures
-stuct||struct
 strucuture||structure
+stuct||struct
 stucture||structure
 sturcture||structure
 subdirectoires||subdirectories
 suble||subtle
-substract||subtract
 submited||submitted
 submition||submission
-suceed||succeed
+substract||subtract
 succesfully||successfully
 succesful||successful
 successed||succeeded
 successfull||successful
 successfuly||successfully
+suceed||succeed
 sucessfully||successfully
 sucessful||successful
 sucess||success
@@ -1344,8 +1344,8 @@ superseeded||superseded
 suplied||supplied
 suported||supported
 suport||support
-supportet||supported
 suppored||supported
+supportet||supported
 supportin||supporting
 suppoted||supported
 suppported||supported
@@ -1355,25 +1355,25 @@ surpressed||suppressed
 surpresses||suppresses
 susbsystem||subsystem
 suspeneded||suspended
-suspsend||suspend
 suspicously||suspiciously
+suspsend||suspend
 swaping||swapping
 switchs||switches
-swith||switch
 swithable||switchable
-swithc||switch
 swithced||switched
 swithcing||switching
+swithc||switch
 swithed||switched
 swithing||switching
+swith||switch
 swtich||switch
 syfs||sysfs
 symetric||symmetric
 synax||syntax
 synchonized||synchronized
 synchronuously||synchronously
-syncronize||synchronize
 syncronized||synchronized
+syncronize||synchronize
 syncronizing||synchronizing
 syncronus||synchronous
 syste||system
@@ -1386,8 +1386,8 @@ targetting||targeting
 taskelt||tasklet
 teh||the
 temorary||temporary
-temproarily||temporarily
 temperture||temperature
+temproarily||temporarily
 thead||thread
 therfore||therefore
 thier||their
@@ -1396,17 +1396,16 @@ threee||three
 threshhold||threshold
 thresold||threshold
 throught||through
-trackling||tracking
-troughput||throughput
 thses||these
-tiggers||triggers
 tiggered||triggered
-tipically||typically
+tiggers||triggers
 timeing||timing
 timout||timeout
+tipically||typically
 tmis||this
 toogle||toggle
 torerable||tolerable
+trackling||tracking
 traking||tracking
 tramsmitted||transmitted
 tramsmit||transmit
@@ -1423,9 +1422,10 @@ transormed||transformed
 trasfer||transfer
 trasmission||transmission
 treshold||threshold
-triggerd||triggered
 trigerred||triggered
 trigerring||triggering
+triggerd||triggered
+troughput||throughput
 trun||turn
 tunning||tuning
 ture||true
@@ -1433,13 +1433,14 @@ tyep||type
 udpate||update
 uesd||used
 uknown||unknown
-usccess||success
+unamed||unnamed
 uncommited||uncommitted
 uncompatible||incompatible
 unconditionaly||unconditionally
 undeflow||underflow
 underun||underrun
 unecessary||unnecessary
+uneeded||unneeded
 unexecpted||unexpected
 unexepected||unexpected
 unexpcted||unexpected
@@ -1448,29 +1449,27 @@ unexpeted||unexpected
 unexpexted||unexpected
 unfortunatelly||unfortunately
 unifiy||unify
-uniterrupted||uninterrupted
 unintialized||uninitialized
+uniterrupted||uninterrupted
 unitialized||uninitialized
 unkmown||unknown
 unknonw||unknown
 unknow||unknown
 unkown||unknown
-unamed||unnamed
-uneeded||unneeded
-unneded||unneeded
+unmached||unmatched
 unneccecary||unnecessary
 unneccesary||unnecessary
 unneccessary||unnecessary
 unnecesary||unnecessary
+unneded||unneeded
 unneedingly||unnecessarily
 unnsupported||unsupported
-unmached||unmatched
 unregester||unregister
 unresgister||unregister
 unrgesiter||unregister
 unsinged||unsigned
-unstabel||unstable
 unsolicitied||unsolicited
+unstabel||unstable
 unsuccessfull||unsuccessful
 unsuported||unsupported
 untill||until
@@ -1478,6 +1477,7 @@ unuseful||useless
 unvalid||invalid
 upate||update
 upsupported||unsupported
+usccess||success
 usefule||useful
 usefull||useful
 usege||usage
@@ -1497,8 +1497,8 @@ variantions||variations
 varible||variable
 varient||variant
 vaule||value
-verbse||verbose
 veify||verify
+verbse||verbose
 verisons||versions
 verison||version
 verson||version
@@ -1512,13 +1512,13 @@ vunerable||vulnerable
 wakeus||wakeups
 wathdog||watchdog
 wating||waiting
-wiat||wait
 wether||whether
 whataver||whatever
 whcih||which
 whenver||whenever
 wheter||whether
 whe||when
+wiat||wait
 wierd||weird
 wiil||will
 wirte||write



